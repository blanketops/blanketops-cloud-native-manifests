#!/bin/bash

kubectl create namespace localstack
helm repo add localstack-repo https://helm.localstack.cloud
helm upgrade --install localstack localstack-repo/localstack --namespace localstack

sleep 10

export NODE_PORT=$(kubectl get --namespace "localstack" -o jsonpath="{.spec.ports[0].nodePort}" services localstack)
export NODE_IP=$(kubectl get nodes --namespace "localstack" -o jsonpath="{.items[0].status.addresses[0].address}")
echo http://$NODE_IP:$NODE_PORT

helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane crossplane-stable/crossplane --namespace crossplane-system --create-namespace

sleep 30

kubectl apply -f secret.yaml

sleep 60

cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-s3
spec:
  package: xpkg.upbound.io/upbound/provider-aws-s3:v0.40.0
EOF

sleep 10

cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-sqs
spec:
  package: xpkg.upbound.io/upbound/provider-aws-sqs:v0.40.0
EOF

sleep 30
kubectl apply -f provider_config.yaml
sleep 30

cat <<EOF | kubectl apply -f -
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-sqs
spec:
  package: xpkg.upbound.io/upbound/provider-aws-sqs:v0.40.0
EOF

sleep 30

cat <<EOF | kubectl apply -f -
apiVersion: s3.aws.upbound.io/v1beta1
kind: Bucket
metadata:
  name: crossplane-test-bucket
spec:
  forProvider:
    region: eu-north-1
EOF

sleep 30

kubectl get buckets
kubectl describe buckets


cat <<EOF | kubectl apply -f -
apiVersion: sqs.aws.upbound.io/v1beta1
kind: Queue
metadata:
  name: crossplane-test-queue
spec:
  forProvider:
    name: crossplane-test-queue
    region: us-east-1
EOF

sleep 30

kubectl get queues


