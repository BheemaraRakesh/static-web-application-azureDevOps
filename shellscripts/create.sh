#!bin/bash

export STORAGE_ACCOUNT=rakeshstorage0103938
export MYCONTAINER=mycontainer
export LOCATION=centralindia
export RESOURCE_GROUP=myResourceGroup
export IP_ADDRESS=4.213.52.212

az group create --name $RESOURCE_GROUP --location $LOCATION
echo "created Resource Group"

az storage account create --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --location $LOCATION --sku Standard_LRS --kind StorageV2
echo "created Storage Account"

az storage container create --name $MYCONTAINER --account-name $STORAGE_ACCOUNT --auth-mode login
echo "created Storage Container"

az storage blob service-properties delete-policy update --account-name $STORAGE_ACCOUNT --enable true --days-retained 30 --auth-mode login
echo "enabled soft delete for blobs"

az storage account update --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --default-action Deny 
echo "updated Storage Account to deny all network access by default"

az storage account network-rule add --account-name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --ip-address $IP_ADDRESS
echo "added IP address to Storage Account network rules"
