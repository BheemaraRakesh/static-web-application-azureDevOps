#!/bin/bash

# This script is used to create a virtual network and subnets in Azure using the Azure CLI.
export RESOURCE_GROUP=myResourceGroup
export LOCATION=centralindia
export VNET_NAME=myVnet
export SUBNET1=mySubnet1
export SUBNET2=mySubnet2
export ADDRESS_PREFIX=10.0.0.0/16
export SUBNET1_PREFIX=10.0.1.0/24
export SUBNET2_PREFIX=10.0.2.0/24

#Resource group already created.
# Create a virtual network
echo "Creating virtual network..."
az network vnet create --resource-group $RESOURCE_GROUP --name $VNET_NAME --address-prefix $ADDRESS_PREFIX --location $LOCATION

# Create subnets
echo "Creating subnets..."
az network vnet subnet create --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $SUBNET1 --address-prefix $SUBNET1_PREFIX
az network vnet subnet create --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $SUBNET2 --address-prefix $SUBNET2_PREFIX