export RESOURCE_GROUP=myResourceGroup
export CLUSTER_NAME=myAKSCluster
export LOCATION=centralindia

# Resource group already exists
#AKS cluster creation
az aks create --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --location $LOCATION --node-count 1 --node-vm-size standard_b16als_v2