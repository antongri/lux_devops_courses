## Description
This code creates EC2 instances and user at AWS. 
EC2 instances are going to be used by students for practical use cases

## Prerequisites
1. AWS user account with access key - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html
2. Installed terraform 0.12 or higher

## Before execution
1. Inside main.tf chaange amoutn of EC2 insances that are going to be create. Change instance_count
2. export AWS_ACCESS_KEY_ID=`id goes here`
3. export AWS_SECRET_ACCESS_KEY=`secret key goes here`

## Execution
```
terraform init
terraform plan -out tfplan_create
terraform apply tfplan_create
```

## List IP addresses of created EC2 instances and share with students
```
aws ec2 describe-instances --query "Reservations[].Instances[].PublicIpAddress"  --region us-west-1
```
Use training ssh key in order to connect to EC2 instances. User ubuntu, same key for all instances

### Login to ECR
```
aws ecr get-login --region us-west-1
```

## Destry infrastructure
```
terraform init
terraform plan -destroy -out tfplan_destroy
terraform plan -out tfplan_create
```