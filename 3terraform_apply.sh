#!/bin/bash

#deploy the resources to terraform
cd /var/lib/jenkins/workspace/terraform_deploy/jenkins_server/

DIR2=/var/lib/jenkins/workspace/terraform_deploy/jenkins_server/.terraform

if [ -d "$DIR2" ];
then
    echo "$DIR2 exists."
   
else
    terraform init
fi


terraform apply -var 'region_selector=$MY_REGION' --auto-approve
