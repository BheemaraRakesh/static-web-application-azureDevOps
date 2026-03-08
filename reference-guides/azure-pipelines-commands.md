# Azure Pipelines Commands Reference

Commands for managing CI/CD pipelines, builds, and releases in Azure DevOps.

## Pipeline Management
```bash
# List pipelines
az pipelines list --project "My Project" --organization https://dev.azure.com/myorg

# Show pipeline
az pipelines show --id 1 --project "My Project" --organization https://dev.azure.com/myorg

# Create pipeline
az pipelines create --name "CI Pipeline" --description "Continuous integration" --repository myrepo --branch main --repository-type tfsgit --project "My Project" --organization https://dev.azure.com/myorg --yaml-path azure-pipelines.yml

# Update pipeline
az pipelines update --id 1 --description "Updated description" --project "My Project" --organization https://dev.azure.com/myorg

# Delete pipeline
az pipelines delete --id 1 --project "My Project" --organization https://dev.azure.com/myorg --yes
```

## Builds
```bash
# List builds
az pipelines build list --project "My Project" --organization https://dev.azure.com/myorg

# Queue build
az pipelines build queue --definition-id 1 --project "My Project" --organization https://dev.azure.com/myorg

# Show build
az pipelines build show --id 123 --project "My Project" --organization https://dev.azure.com/myorg

# Cancel build
az pipelines build cancel --id 123 --project "My Project" --organization https://dev.azure.com/myorg

# Download build artifacts
az pipelines build artifact download --artifact-name drop --build-id 123 --destination ./artifacts --project "My Project" --organization https://dev.azure.com/myorg
```

## Releases
```bash
# List release definitions
az pipelines release definition list --project "My Project" --organization https://dev.azure.com/myorg

# Create release
az pipelines release create --definition-id 1 --project "My Project" --organization https://dev.azure.com/myorg

# List releases
az pipelines release list --project "My Project" --organization https://dev.azure.com/myorg

# Show release
az pipelines release show --id 1 --project "My Project" --organization https://dev.azure.com/myorg

# Deploy release
az pipelines release deploy --release-id 1 --environment-id 1 --project "My Project" --organization https://dev.azure.com/myorg
```

## Pipeline Validation
```bash
# Validate pipeline YAML
az pipelines build definition validate --path azure-pipelines.yml --project "My Project" --organization https://dev.azure.com/myorg
```

## Variables and Secrets
```bash
# List pipeline variables
az pipelines variable list --pipeline-id 1 --project "My Project" --organization https://dev.azure.com/myorg

# Set pipeline variable
az pipelines variable create --name "env" --value "production" --pipeline-id 1 --project "My Project" --organization https://dev.azure.com/myorg

# Update pipeline variable
az pipelines variable update --name "env" --value "staging" --pipeline-id 1 --project "My Project" --organization https://dev.azure.com/myorg
```

## Agent and Pool Management
```bash
# List agent pools
az pipelines pool list --organization https://dev.azure.com/myorg

# Create self-hosted agent
az pipelines agent create --pool-id 1 --agent-name "my-agent" --work-folder /opt/azure --organization https://dev.azure.com/myorg --token <pat>
```

## Pipeline Runs
```bash
# Get pipeline runs
az pipelines runs list --project "My Project" --organization https://dev.azure.com/myorg

# Show run details
az pipelines runs show --id 123 --project "My Project" --organization https://dev.azure.com/myorg

# Rerun failed jobs
az pipelines runs rerun --id 123 --job-ids 1 2 3 --project "My Project" --organization https://dev.azure.com/myorg
```

## Approvals and Gates
```bash
# List approvals
az pipelines release approval list --release-id 1 --project "My Project" --organization https://dev.azure.com/myorg

# Approve release
az pipelines release approval approve --approval-id 1 --comments "Approved for production" --project "My Project" --organization https://dev.azure.com/myorg
```

## Artifacts
```bash
# Publish artifact
az pipelines runs artifact upload --run-id 123 --artifact-name "drop" --path ./build --project "My Project" --organization https://dev.azure.com/myorg

# Download artifact
az pipelines runs artifact download --run-id 123 --artifact-name "drop" --destination ./downloads --project "My Project" --organization https://dev.azure.com/myorg
```

## Best Practices
- Use YAML pipelines for version control
- Implement multi-stage pipelines
- Use templates for reusability
- Set up proper triggers and schedules
- Implement approvals for production deployments
- Use variable groups for secrets
- Enable pipeline analytics
- Set up notifications for build status
- Use self-hosted agents for specialized workloads
- Regularly review and optimize pipeline performance