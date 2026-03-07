export RESOURCE_GROUP=myResourceGroup
export LOCATION=australiaeast
export SUBNET1=mySubnet1
export SUBNET2=mySubnet2
export VNET_NAME=myVnet
export NSG_NAME=myNSG
export publicIPName=myPublicIP
export VM_NAME=myVM
export ADMIN_USERNAME=azureuser
export nicName=myNic

#created resource group and virtual network with subnets in previous tasks.

# Create a network security group
echo "Creating network security group..."
az network nsg create \
    --resource-group $RESOURCE_GROUP \
    --name $NSG_NAME \
    --location $LOCATION

# Add an SSH rule to the NSG
echo "Adding SSH rule to NSG..."
az network nsg rule create \
    --resource-group $RESOURCE_GROUP \
    --nsg-name $NSG_NAME \
    --name AllowSSH \
    --protocol Tcp \
    --priority 1000 \
    --destination-port-range 22 \
    --access Allow 

# Create a public IP address
echo "Creating public IP address..."
az network public-ip create \
    --resource-group $RESOURCE_GROUP \
    --name $publicIPName \
    --location $LOCATION 

# Create a network interface and associate it with the NSG and public IP
echo "Creating network interface..."
az network nic create \
    --resource-group $RESOURCE_GROUP \
    --name $nicName \
    --location $LOCATION \
    --subnet $SUBNET1 \
    --vnet-name $VNET_NAME \
    --network-security-group $NSG_NAME \
    --public-ip-address $publicIPName

# Create a virtual machine and associate it with the network interface
echo "Creating virtual machine..."
az vm create \
    --resource-group $RESOURCE_GROUP \
    --name $VM_NAME \
    --location $LOCATION \
    --nics $nicName \
    --image Ubuntu2204 \
    --size Standard_B2ms \
    --admin-username $ADMIN_USERNAME \
    --admin-password "Rakesh010302@" \
    --authentication-type password 



