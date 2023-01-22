#!/bin/bash

# use this to install yq package on the jenkins_server:

# wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&\
#     chmod +x /usr/bin/yq


#check for a my_file.yml

cd /var/lib/jenkins/workspace/terraform_deploy/jenkins_server/

FILE=my_file.yml

if [ -f "$FILE" ];
then
    echo "$FILE exists."
    MY_REGION=`yq '.aws_regions.region' $FILE`
else
    echo "$FILE is missing!"
fi

