#!/bin/bash

ibmcloud login -sso

export ROOT_PATH=$(pwd)
export RESOURCE_GROUP=default
export REGION=us-south
export VSI_NAME=YOUR_VSI_NAME

ibmcloud target -g $RESOURCE_GROUP
ibmcloud target -r $REGION
VSI_IP=$(ibmcloud is instances | grep "$VSI_NAME" | awk '{print $5;}')
echo "$VSI_NAME IP: $VSI_IP"

export PATH_TO_PRIVATE_KEY_FILE='~/.ssh/YOUR_PRIV_FILE'
cd $ROOT_PATH

ssh -i $PATH_TO_PRIVATE_KEY_FILE root@$VSI_IP
