#!/bin/bash

kubectl delete namespace crossplane-system
kubectl delete namespace localstack
kubectl delete providers --all
helm repo remove localstack-repo
helm repo remove crossplane-stable
sleep 10
