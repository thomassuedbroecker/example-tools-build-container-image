#!/bin/bash

ibmcloud login -sso

export ROOT_PATH=$(pwd)
export RESOURCE_GROUP=default
export REGION=us-south
export VSI_NAME=$YOUR_VSI_NAME
export KEY_PRIV_FILE=$YOUR_KEY_PRIV_FILE

ibmcloud target -g $RESOURCE_GROUP
ibmcloud target -r $REGION
VSI_IP=$(ibmcloud is instances | grep "$VSI_NAME" | awk '{print $5;}')
echo "$VSI_NAME IP: $VSI_IP"

cd ~/.ssh
PATH_SSH=$(pwd)

export PATH_TO_PRIVATE_KEY_FILE="$PATH_SSH/$KEY_PRIV_FILE"
chmod 600 "$PATH_TO_PRIVATE_KEY_FILE"
cd $ROOT_PATH

ssh -i $PATH_TO_PRIVATE_KEY_FILE root@$VSI_IP
