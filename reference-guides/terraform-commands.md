# Terraform Commands Reference

Essential Terraform commands for infrastructure as code, provisioning, and management.

## Basic Workflow
```bash
# Initialize working directory
terraform init

# Format configuration files
terraform fmt

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy infrastructure
terraform destroy
```

## State Management
```bash
# Show state
terraform show

# List resources in state
terraform state list

# Show specific resource
terraform state show aws_instance.example

# Move resource in state
terraform state mv aws_instance.old aws_instance.new

# Remove resource from state
terraform state rm aws_instance.example

# Pull remote state
terraform state pull > terraform.tfstate

# Push local state to remote
terraform state push terraform.tfstate
```

## Workspace Management
```bash
# List workspaces
terraform workspace list

# Create workspace
terraform workspace new production

# Select workspace
terraform workspace select production

# Show current workspace
terraform workspace show

# Delete workspace
terraform workspace delete development
```

## Import and Refresh
```bash
# Import existing resource
terraform import aws_instance.example i-1234567890abcdef0

# Refresh state
terraform refresh

# Plan with refresh
terraform plan -refresh-only
```

## Output and Variables
```bash
# Show outputs
terraform output

# Show specific output
terraform output instance_ip

# Set variable value
terraform plan -var="instance_type=t2.micro"

# Use variable file
terraform apply -var-file="production.tfvars"
```

## Graph and Debug
```bash
# Generate dependency graph
terraform graph

# Save graph to file
terraform graph > graph.dot

# Enable debug logging
TF_LOG=DEBUG terraform apply

# Set log level
TF_LOG=TRACE terraform plan
```

## Remote State
```bash
# Configure remote state (in .tf files)
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state"
    storage_account_name = "terraformstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Migrate state to remote
terraform init -migrate-state
```

## Modules
```bash
# Get modules
terraform get

# Update modules
terraform get -update

# Initialize with upgrade
terraform init -upgrade
```

## Azure Provider Examples
```hcl
# Provider configuration
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Resource group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "East US"
}

# Virtual network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# AKS cluster
resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "example"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
```

## Best Practices
- Use modules for reusable components
- Implement remote state for team collaboration
- Use workspaces for environment separation
- Validate configurations before applying
- Use variables for parameterization
- Implement proper locking for state
- Regularly backup state files
- Use semantic versioning for modules
- Implement CI/CD for Terraform changes
- Use terraform-docs for documentation