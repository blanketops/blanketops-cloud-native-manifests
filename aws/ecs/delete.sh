#!/bin/bash

echo "Deleting all AWS ECS Resources----"

kubectl delete capacityprovider.ecs.aws.upbound.io --all --force
kubectl delete cluster.ecs.aws.upbound.io --all --force
kubectl delete clustercapacityproviders.ecs.aws.upbound.io --all --force
kubectl delete service.ecs.aws.upbound.io --all --force
kubectl delete taskdefinition.ecs.aws.upbound.io --all --force


# kubectl delete lifecyclepolicy.ecr.aws.upbound.io/crossplane-blanketops-ecr-lifecycle-policy
# kubectl delete pullthroughcacherule.ecr.aws.upbound.io/crossplane-blanketops-ecr-pullthroughcache-rule
# kubectl delete registrypolicy.ecr.aws.upbound.io/crossplane-blanketops-ecr-registry-policy
# kubectl delete registryscanningconfiguration.ecr.aws.upbound.io/crossplane-registry-scanning-configuration
# kubectl delete repository.ecr.aws.upbound.io/crossplane-blanketops-ecr-repository
# kubectl delete repositorypolicy.ecr.aws.upbound.io/crossplane-blanketops-ecr-repository-policy


echo "---Complete!!"