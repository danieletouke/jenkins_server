#!/bin/bash

#deploy the resources to terraform


terraform apply -var 'desired_region=MY_REGION' --auto-approve
