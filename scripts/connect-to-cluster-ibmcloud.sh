#!/bin/bash

ibmcloud login -sso

export ROOT_PATH=$(pwd)
export RESOURCE_GROUP=default
export REGION=us-south
export CLUSTERNAME=YOUR_CLUSTER_NAME

ibmcloud target -g $RESOURCE_GROUP
ibmcloud target -r $REGION
ibmcloud ks cluster config --cluster $CLUSTERNAME
kubectl config current-context
