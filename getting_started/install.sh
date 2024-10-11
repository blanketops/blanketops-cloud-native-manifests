#!/bin/bash

helm repo add crossplane-stable https://charts.crossplane.io/stable helm repo update

sleep 3
clear

helm install crossplane crossplane-stable/crossplane --namespace crossplane-system --create-namespace

sleep 3
clear

kubectl get pods -n crossplane-system

sleep 3
clear

kubectl api-resources  | grep crossplane

sleep 3
clear

kubectl get providers
