export STORAGE_ACCOUNT=rakeshstorage0103938
export MYCONTAINER=mycontainer
export LOCATION=centralindia
export RESOURCE_GROUP=myResourceGroup
export IP_ADDRESS=4.213.52.212
export CONTAINER_KEY=$(az storage account keys list --account-name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP -o tsv --query "[0].value")

az storage blob undelete --account-name $STORAGE_ACCOUNT --container-name $MYCONTAINER --name four.txt --auth-mode login --account-key $CONTAINER_KEY

az storage blob list --account-name $STORAGE_ACCOUNT --container-name $MYCONTAINER --auth-mode login --account-key $CONTAINER_KEY -o table