#!/bin/bash

#deploy the resources to terraform


terraform apply -var 'region_selector=MY_REGION' --auto-approve
