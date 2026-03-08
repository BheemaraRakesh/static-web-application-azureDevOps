# Azure CLI Commands Reference

Essential Azure CLI commands for managing cloud resources in production environments.

## Authentication
```bash
# Login to Azure
az login

# Login with service principal
az login --service-principal -u <app-id> -p <password> --tenant <tenant-id>

# Set subscription
az account set --subscription <subscription-id>

# List subscriptions
az account list --output table
```

## Resource Group Management
```bash
# Create resource group
az group create --name myResourceGroup --location eastus

# List resource groups
az group list --output table

# Show resource group details
az group show --name myResourceGroup

# Delete resource group
az group delete --name myResourceGroup --yes --no-wait
```

## Azure Kubernetes Service (AKS)
```bash
# Create AKS cluster
az aks create --resource-group myRG --name myAKS --node-count 3 --enable-addons monitoring --generate-ssh-keys

# Get AKS credentials
az aks get-credentials --resource-group myRG --name myAKS

# List AKS clusters
az aks list --output table

# Scale AKS nodes
az aks scale --resource-group myRG --name myAKS --node-count 5

# Upgrade AKS cluster
az aks upgrade --resource-group myRG --name myAKS --kubernetes-version 1.27.0

# Attach ACR to AKS
az aks update --name myAKS --resource-group myRG --attach-acr myacr

# Enable Azure Monitor for containers
az aks enable-addons --addons monitoring --name myAKS --resource-group myRG --workspace-resource-id <workspace-id>
```

## Azure Container Registry (ACR)
```bash
# Create ACR
az acr create --resource-group myRG --name myacr --sku Premium

# Login to ACR
az acr login --name myacr

# Build image in ACR
az acr build --registry myacr --image myapp:v1.0 .

# List repositories
az acr repository list --name myacr --output table

# List tags
az acr repository show-tags --name myacr --repository myapp

# Delete image
az acr repository delete --name myacr --image myapp:old-tag --yes

# Set up geo-replication
az acr replication create --registry myacr --location westus
```

## Networking
```bash
# Create VNet
az network vnet create --resource-group myRG --name myVNet --address-prefix 10.0.0.0/16

# Create subnet
az network vnet subnet create --resource-group myRG --vnet-name myVNet --name mySubnet --address-prefix 10.0.1.0/24

# Create NSG
az network nsg create --resource-group myRG --name myNSG

# Create NSG rule
az network nsg rule create --resource-group myRG --nsg-name myNSG --name AllowSSH --priority 100 --destination-port-ranges 22 --access Allow --protocol Tcp

# Create public IP
az network public-ip create --resource-group myRG --name myPublicIP --allocation-method Static

# Create load balancer
az network lb create --resource-group myRG --name myLB --public-ip-address myPublicIP --frontend-ip-name myFrontEnd --backend-pool-name myBackEnd
```

## Virtual Machines
```bash
# Create VM
az vm create --resource-group myRG --name myVM --image Ubuntu2204 --admin-username azureuser --generate-ssh-keys --size Standard_DS2_v2

# List VMs
az vm list --output table

# Start VM
az vm start --resource-group myRG --name myVM

# Stop VM
az vm deallocate --resource-group myRG --name myVM

# Restart VM
az vm restart --resource-group myRG --name myVM

# Delete VM
az vm delete --resource-group myRG --name myVM --yes

# Resize VM
az vm resize --resource-group myRG --name myVM --size Standard_DS3_v2
```

## Storage
```bash
# Create storage account
az storage account create --name mystorageaccount --resource-group myRG --location eastus --sku Standard_LRS --kind StorageV2

# Create blob container
az storage container create --name mycontainer --account-name mystorageaccount

# Upload file to blob
az storage blob upload --account-name mystorageaccount --container-name mycontainer --name myfile.txt --file ./myfile.txt

# List blobs
az storage blob list --account-name mystorageaccount --container-name mycontainer --output table
```

## Security
```bash
# Create Key Vault
az keyvault create --name myKeyVault --resource-group myRG --location eastus

# Store secret
az keyvault secret set --vault-name myKeyVault --name mySecret --value "secret-value"

# Retrieve secret
az keyvault secret show --vault-name myKeyVault --name mySecret

# Assign RBAC role
az role assignment create --assignee user@domain.com --role "Contributor" --scope /subscriptions/<subscription-id>
```

## Cost Management
```bash
# View costs
az costmanagement query --type ActualCost --timeframe MonthToDate --dataset-granularity Daily

# Create budget
az consumption budget create --amount 1000 --time-grain Monthly --name myBudget --category Cost
```

## Monitoring
```bash
# Create Log Analytics workspace
az monitor log-analytics workspace create --resource-group myRG --name myWorkspace --location eastus

# Set diagnostic settings
az monitor diagnostic-settings create --name myDiag --resource /subscriptions/<sub-id>/resourceGroups/myRG/providers/Microsoft.ContainerService/managedClusters/myAKS --logs '[{"category": "kube-apiserver", "enabled": true}]' --metrics '[{"category": "AllMetrics", "enabled": true}]' --workspace /subscriptions/<sub-id>/resourceGroups/myRG/providers/Microsoft.OperationalInsights/workspaces/myWorkspace
```

## Best Practices
- Use `--output table` for readable output
- Use `--yes` for non-interactive deletions
- Use `--no-wait` for long-running operations
- Always specify resource group and location
- Use service principals for automated scripts
- Regularly update Azure CLI: `az upgrade`