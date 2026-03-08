# Azure DevOps Commands Reference

Commands and operations for managing Azure DevOps organizations, projects, and general administration.

## Organization Management
```bash
# List organizations (via Azure CLI)
az devops organization list

# Create project
az devops project create --name "My Project" --description "Project description" --visibility private

# List projects
az devops project list --organization https://dev.azure.com/myorg

# Delete project
az devops project delete --id <project-id> --organization https://dev.azure.com/myorg --yes
```

## User and Security
```bash
# Add user to organization
az devops user add --email user@domain.com --organization https://dev.azure.com/myorg

# List users
az devops user list --organization https://dev.azure.com/myorg

# Create security group
az devops security group create --name "Developers" --description "Development team" --project "My Project" --organization https://dev.azure.com/myorg

# Add user to group
az devops security group membership add --group-id <group-id> --user-id <user-id> --organization https://dev.azure.com/myorg
```

## Extensions
```bash
# List installed extensions
az devops extension list --organization https://dev.azure.com/myorg

# Install extension
az devops extension install --extension-id <extension-id> --publisher-id <publisher-id> --organization https://dev.azure.com/myorg

# Uninstall extension
az devops extension uninstall --extension-id <extension-id> --publisher-id <publisher-id> --organization https://dev.azure.com/myorg
```

## Service Connections
```bash
# List service connections
az devops service-endpoint list --project "My Project" --organization https://dev.azure.com/myorg

# Create Azure RM service connection
az devops service-endpoint azurerm create --azure-rm-service-principal-id <sp-id> --azure-rm-subscription-id <sub-id> --azure-rm-subscription-name "My Subscription" --azure-rm-tenant-id <tenant-id> --name "Azure-Prod" --project "My Project" --organization https://dev.azure.com/myorg
```

## Agent Pools and Agents
```bash
# List agent pools
az pipelines pool list --organization https://dev.azure.com/myorg

# Create agent pool
az pipelines pool create --name "My Pool" --organization https://dev.azure.com/myorg

# List agents
az pipelines agent list --pool-id <pool-id> --organization https://dev.azure.com/myorg

# Update agent
az pipelines agent update --pool-id <pool-id> --agent-id <agent-id> --organization https://dev.azure.com/myorg --enable-auto-update true
```

## Variable Groups
```bash
# Create variable group
az pipelines variable-group create --name "Production Variables" --project "My Project" --organization https://dev.azure.com/myorg --variables key1=value1 key2=value2

# List variable groups
az pipelines variable-group list --project "My Project" --organization https://dev.azure.com/myorg

# Update variable group
az pipelines variable-group variable update --group-id <group-id> --name key1 --value newvalue --project "My Project" --organization https://dev.azure.com/myorg
```

## Notifications
```bash
# List notification settings
az devops notification list --organization https://dev.azure.com/myorg

# Create notification subscription
az devops notification subscription create --event-type "build.complete" --filter "status=failed" --address user@domain.com --organization https://dev.azure.com/myorg
```

## Audit
```bash
# Get audit logs
az devops audit list --organization https://dev.azure.com/myorg --start-date 2024-01-01 --end-date 2024-01-31
```

## Wiki
```bash
# Create wiki
az devops wiki create --name "Project Wiki" --project "My Project" --organization https://dev.azure.com/myorg --type projectwiki

# List wikis
az devops wiki list --project "My Project" --organization https://dev.azure.com/myorg
```

## Best Practices
- Use service principals for automation
- Implement least privilege access
- Regularly review security groups and permissions
- Use variable groups for sensitive data
- Set up notifications for critical events
- Enable audit logging
- Use project templates for consistency
- Regularly update extensions and agents