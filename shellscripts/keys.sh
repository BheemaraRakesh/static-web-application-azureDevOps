export STORAGE_ACCOUNT=rakeshstorage0103938
export MYCONTAINER=mycontainer
export LOCATION=centralindia
export RESOURCE_GROUP=myResourceGroup
export IP_ADDRESS=4.213.52.212

az storage account keys list --account-name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP -o table


