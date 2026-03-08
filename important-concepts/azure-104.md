# Azure Administrator Associate (AZ-104) Concepts

## Overview
Azure Administrator Associate (AZ-104) certification focuses on managing Azure resources, implementing governance, and maintaining services. It covers hands-on administration of Azure infrastructure.

## Key Concepts

### 1. Azure Resource Management

#### Resource Groups
Logical containers for resources with common lifecycle.

**Best Practices:**
- Use consistent naming
- Group by application or environment
- Use tags for organization

#### Azure Resource Manager (ARM) Templates
JSON files defining infrastructure as code.

**Example ARM Template Structure:**
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "variables": {},
  "resources": [],
  "outputs": {}
}
```

#### Azure CLI and PowerShell
Command-line tools for resource management.

### 2. Virtual Machines

#### VM Creation and Configuration
- Size selection based on workload
- OS disk and data disks
- Network configuration

**Example:**
```bash
# Create VM
az vm create --resource-group myRG --name myVM --image Ubuntu2204 --admin-username azureuser --generate-ssh-keys --size Standard_DS1_v2
```

#### VM Extensions
Install software and configure VMs post-deployment.

**Common Extensions:**
- Custom Script Extension
- Desired State Configuration (DSC)
- Azure Monitor Agent

#### VM Availability
- Availability Sets
- Availability Zones
- Virtual Machine Scale Sets (VMSS)

### 3. Storage Accounts

#### Storage Account Types
- **General Purpose v2:** Most features, lowest cost
- **General Purpose v1:** Legacy
- **Blob Storage:** Blob-only storage
- **File Storage:** File shares only

#### Redundancy Options
- LRS (Local Redundant Storage)
- ZRS (Zone Redundant Storage)
- GRS (Geo-Redundant Storage)
- GZRS (Geo-Zone Redundant Storage)

#### Access Tiers
- Hot: Frequent access
- Cool: Infrequent access
- Archive: Long-term retention

### 4. Virtual Networks

#### VNet Concepts
- Address spaces and subnets
- Network Security Groups (NSGs)
- Route tables
- Service endpoints and private endpoints

**Example VNet Configuration:**
```bash
# Create VNet with subnet
az network vnet create --resource-group myRG --name myVNet --address-prefix 10.0.0.0/16 --subnet-name mySubnet --subnet-prefix 10.0.0.0/24
```

#### VNet Peering
Connect VNets across subscriptions or regions.

#### VPN Gateway
Secure connections between Azure VNets and on-premises networks.

### 5. Azure Active Directory

#### User and Group Management
- Create and manage users
- Group-based access control
- Guest user access

#### Role-Based Access Control (RBAC)
Built-in roles and custom roles.

**Common Built-in Roles:**
- Owner: Full access
- Contributor: Manage resources
- Reader: Read-only access

#### Azure AD Connect
Synchronize on-premises AD with Azure AD.

### 6. Azure Backup and Recovery

#### Azure Backup
Protect VMs, files, and applications.

**Backup Components:**
- Recovery Services Vault
- Backup policies
- Restore points

#### Azure Site Recovery
Disaster recovery for VMs and applications.

### 7. Azure Monitor

#### Monitoring Components
- Metrics: Numeric data over time
- Logs: Detailed records
- Alerts: Notifications based on conditions

#### Log Analytics
Query and analyze log data.

**Example KQL Query:**
```kusto
VMComputer
| where TimeGenerated > ago(1h)
| summarize avg(CPUPercent) by Computer
```

#### Application Insights
Monitor application performance and usage.

### 8. Azure Policy and Governance

#### Azure Policy
Enforce organizational standards.

**Policy Structure:**
- Policy definition
- Initiative (collection of policies)
- Assignments

#### Resource Locks
Prevent accidental changes.

#### Management Groups
Organize subscriptions hierarchically.

### 9. Azure App Service

#### App Service Plans
Define compute resources for apps.

**Tiers:**
- Free/Shared
- Basic/Standard/Premium
- Isolated

#### Deployment Methods
- Git integration
- FTP
- Azure DevOps
- Container deployment

### 10. Azure Kubernetes Service (AKS)

#### AKS Concepts
- Node pools
- Networking (kubenet vs Azure CNI)
- Identity and access
- Storage options

#### Cluster Management
- Scaling
- Upgrades
- Monitoring

## Real Project Examples

### VM Deployment with Monitoring
```bash
# Create resource group
az group create --name prod-rg --location eastus

# Create VNet and subnet
az network vnet create --resource-group prod-rg --name prod-vnet --address-prefix 10.0.0.0/16 --subnet-name prod-subnet --subnet-prefix 10.0.0.0/24

# Create NSG
az network nsg create --resource-group prod-rg --name prod-nsg

# Create VM
az vm create --resource-group prod-rg --name prod-vm --vnet-name prod-vnet --subnet prod-subnet --nsg prod-nsg --image Ubuntu2204 --admin-username azureadmin --generate-ssh-keys --size Standard_DS2_v2

# Enable Azure Monitor
az monitor diagnostic-settings create --name diagnostics --resource /subscriptions/<sub-id>/resourceGroups/prod-rg/providers/Microsoft.Compute/virtualMachines/prod-vm --logs '[{"category": "VMLogs", "enabled": true}]' --metrics '[{"category": "AllMetrics", "enabled": true}]' --workspace /subscriptions/<sub-id>/resourceGroups/DefaultResourceGroup/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace
```

### Storage Account with Security
```bash
# Create storage account
az storage account create --name prodstorage --resource-group prod-rg --location eastus --sku Standard_GRS --kind StorageV2 --access-tier Hot --allow-blob-public-access false

# Create containers with different access levels
az storage container create --name private --account-name prodstorage --public-access off
az storage container create --name blob --account-name prodstorage --public-access blob

# Set up lifecycle management
az storage account management-policy create --account-name prodstorage --policy @policy.json
```

### Network Security Implementation
```bash
# Create NSG with rules
az network nsg create --resource-group prod-rg --name web-nsg

# Allow HTTP
az network nsg rule create --resource-group prod-rg --nsg-name web-nsg --name AllowHTTP --priority 100 --destination-port-ranges 80 --access Allow --protocol Tcp

# Allow HTTPS
az network nsg rule create --resource-group prod-rg --nsg-name web-nsg --name AllowHTTPS --priority 101 --destination-port-ranges 443 --access Allow --protocol Tcp

# Deny all other inbound
az network nsg rule create --resource-group prod-rg --nsg-name web-nsg --name DenyAll --priority 4096 --access Deny --protocol "*"

# Associate with subnet
az network vnet subnet update --resource-group prod-rg --vnet-name prod-vnet --name prod-subnet --network-security-group web-nsg
```

## Best Practices
- Use ARM templates for infrastructure deployment
- Implement proper naming conventions
- Use managed identities for authentication
- Enable Azure Backup for critical resources
- Implement Azure Policy for compliance
- Use Azure Monitor for proactive monitoring
- Implement resource locks for production resources
- Use availability sets/zones for high availability
- Regularly review and optimize costs
- Implement proper access controls and RBAC