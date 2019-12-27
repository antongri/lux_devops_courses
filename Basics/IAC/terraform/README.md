# Infrastructure as a code demo using terraform

## Description
This demo demostrates installation of GKE cluster, deployment of demo application - https://github.com/GoogleCloudPlatform/microservices-demo and configuration of Istio with mTLS and Canary releases

## Prerequisites
1. MacOS or Linux
2. Installed openssl
3. Google Cloud Service Account and key - https://cloud.google.com/iam/docs/creating-managing-service-account-keys
4. Name key as terraform.json and copy it to /Basics/IAC/terraform/ folder
5. Installed gcloud (Google SDK) https://cloud.google.com/sdk/install
6. Installed kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl/
7. Installed Terraform 0.12 or higher - https://www.terraform.io/downloads.html
8. Installed Helm - https://helm.sh/docs/intro/install/

## Before execution
Update variables.tf file with mandatory information:
1. project_name = name of the GCP project where k8s cluster is going to be created
2. project_id = GCP project id where k8s cluster is going to be created
3. zones = zone where GKE cluster is going to be hosted
4. region = region where GKE cluster is going to be hosted

## Execution

```
terraform init
terraform plan
terraform apply
sh deploy.sh
```
