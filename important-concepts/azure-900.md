# Azure Fundamentals (AZ-900) Concepts

## Overview
Azure Fundamentals (AZ-900) is the entry-level certification that covers basic cloud concepts, Azure services, and Azure pricing/management. It provides foundational knowledge for cloud computing with Microsoft Azure.

## Key Concepts

### 1. Cloud Computing Models

#### Infrastructure as a Service (IaaS)
Provides virtualized computing resources over the internet.

**Examples:**
- Azure Virtual Machines
- Azure Virtual Networks
- Azure Storage

**Use Case:** When you need full control over the infrastructure.

#### Platform as a Service (PaaS)
Provides a platform allowing customers to develop, run, and manage applications without dealing with infrastructure.

**Examples:**
- Azure App Service
- Azure SQL Database
- Azure Functions

**Use Case:** When you want to focus on application development without managing servers.

#### Software as a Service (SaaS)
Complete software solution delivered over the internet.

**Examples:**
- Office 365
- Outlook.com
- Dynamics 365

**Use Case:** When you want ready-to-use applications.

### 2. Azure Architecture

#### Regions and Availability Zones
- **Region:** Geographical area containing one or more data centers
- **Availability Zone:** Physically separate data centers within a region

**Example:**
```bash
# Create resource in specific region
az group create --name myRG --location eastus
```

#### Resource Groups
Logical containers for Azure resources.

**Example:**
```bash
# Create resource group
az group create --name ProductionRG --location westus2
```

### 3. Core Azure Services

#### Compute Services
- **Virtual Machines:** IaaS VMs
- **App Service:** PaaS for web apps
- **Azure Functions:** Serverless compute
- **Azure Kubernetes Service (AKS):** Managed Kubernetes

#### Storage Services
- **Blob Storage:** Object storage for unstructured data
- **File Storage:** Managed file shares
- **Queue Storage:** Messaging between components
- **Table Storage:** NoSQL key-value store

#### Database Services
- **Azure SQL Database:** Managed SQL Server
- **Cosmos DB:** Globally distributed NoSQL database
- **Azure Database for MySQL/PostgreSQL:** Managed open-source databases

#### Networking Services
- **Virtual Network (VNet):** Isolated network in Azure
- **Load Balancer:** Distribute traffic
- **Application Gateway:** Web traffic load balancer
- **VPN Gateway:** Secure connections

### 4. Azure Identity and Access Management

#### Azure Active Directory (Azure AD)
Identity and access management service.

**Concepts:**
- Users and Groups
- Role-Based Access Control (RBAC)
- Multi-Factor Authentication (MFA)

#### Azure AD Connect
Synchronizes on-premises Active Directory with Azure AD.

### 5. Azure Governance

#### Management Groups
Organize subscriptions hierarchically.

#### Policies
Enforce rules and compliance.

**Example Policy:** Require specific tags on resources.

#### Resource Locks
Prevent accidental deletion or modification.

**Types:**
- Read-only
- Delete

### 6. Azure Monitoring and Management

#### Azure Monitor
Collect, analyze, and act on telemetry.

#### Azure Advisor
Personalized recommendations for best practices.

#### Azure Cost Management
Monitor and control Azure spending.

### 7. Azure Pricing and Support

#### Pricing Calculator
Estimate costs for Azure services.

#### Cost Management Tools
- Budgets
- Alerts
- Cost analysis

#### Support Plans
- Basic
- Developer
- Standard
- Professional Direct
- Premier

## Real Project Examples

### Basic Web Application Deployment
1. Create Resource Group
2. Deploy App Service
3. Configure Custom Domain
4. Set up Monitoring

```bash
# Create resource group
az group create --name webapp-rg --location eastus

# Create App Service plan
az appservice plan create --name myplan --resource-group webapp-rg --sku B1

# Create web app
az webapp create --name mywebapp --resource-group webapp-rg --plan myplan
```

### Storage Account Setup
```bash
# Create storage account
az storage account create --name mystorageaccount --resource-group storage-rg --location eastus --sku Standard_LRS --kind StorageV2

# Create blob container
az storage container create --name mycontainer --account-name mystorageaccount

# Upload file
az storage blob upload --account-name mystorageaccount --container-name mycontainer --name myfile.txt --file ./myfile.txt
```

### Virtual Network Configuration
```bash
# Create virtual network
az network vnet create --resource-group network-rg --name myvnet --address-prefix 10.0.0.0/16 --subnet-name mysubnet --subnet-prefix 10.0.0.0/24

# Create network security group
az network nsg create --resource-group network-rg --name mynsg

# Create security rule
az network nsg rule create --resource-group network-rg --nsg-name mynsg --name AllowSSH --priority 100 --destination-port-ranges 22 --access Allow --protocol Tcp
```

## Best Practices
- Use resource groups to organize resources
- Implement proper naming conventions
- Use tags for resource organization and cost tracking
- Enable Azure Advisor recommendations
- Set up budgets and cost alerts
- Use Azure Policy for governance
- Implement least privilege access
- Regularly review resource usage and costs
- Use availability zones for high availability
- Plan for disaster recovery