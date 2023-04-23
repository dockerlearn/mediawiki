# Mediawiki with mysql server on kubernetes with Helm and terraform

## Introduction

Mediawiki 1.39.3 docker image is built on centos7. It didn't work on centos8 as php 7.4 is needed for latest mediawiki version and remi-release-8.rpm is not present till centos8.4
It's helm chart is being deployed on AKS Cluster with terraform.

Helm chart includes mysql statefulset and mediawiki deployment creating a Standard Loadbalancer.


## Architecture and Application Output

![Mediawiki InitialPage](/Images/initial.png "Intialpage")

**Mediawiki Running**


![Helm Deployment](/Images/helm.png "HelmDeploy")

**Helm Deployment Through Terraform**

![Mediawiki Pods](/Images/pods.png "Pods")

**Mediawiki Pods Running**