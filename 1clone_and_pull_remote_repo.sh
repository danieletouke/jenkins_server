#!/bin/bash

#Clone my github repo

PROJECT=jenkins_server.git


if [ -d "$PROJECT" ];
then
    echo "$PROJECT exists."
else
    git clone https://github.com/danieletouke/jenkins_server.git
fi


cd jenkins_server.git/

if [ $?==0];
then
    echo "great job!!"
fi

git pull

