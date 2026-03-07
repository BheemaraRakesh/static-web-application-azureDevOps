export STORAGE_ACCOUNT=rakeshstorage0103938
export MYCONTAINER=mycontainer
export LOCATION=centralindia
export RESOURCE_GROUP=myResourceGroup
export IP_ADDRESS=4.213.52.212
export CONTAINER_KEY=$(az storage account keys list --account-name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP -o tsv --query "[0].value")


#uploading script 
az storage blob upload --account-name $STORAGE_ACCOUNT --container-name $MYCONTAINER --name four.txt --file /home/bheemararakesh/file.txt --auth-mode login --account-key $CONTAINER_KEY
az storage blob upload --account-name $STORAGE_ACCOUNT --container-name $MYCONTAINER --name image2.png --file /home/bheemararakesh/image.png --auth-mode login --account-key $CONTAINER_KEY

