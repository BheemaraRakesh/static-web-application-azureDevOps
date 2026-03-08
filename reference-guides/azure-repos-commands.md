# Azure Repos Commands Reference

Commands for managing Git repositories, pull requests, and version control in Azure DevOps Repos.

## Repository Management
```bash
# List repositories
az repos list --project "My Project" --organization https://dev.azure.com/myorg

# Create repository
az repos create --name "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Show repository
az repos show --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Delete repository
az repos delete --id <repo-id> --project "My Project" --organization https://dev.azure.com/myorg --yes
```

## Git Operations (via Azure CLI)
```bash
# Clone repository
git clone https://dev.azure.com/myorg/My%20Project/_git/my-repo

# Add remote
git remote add origin https://dev.azure.com/myorg/My%20Project/_git/my-repo

# Push branch
git push origin feature-branch

# Pull changes
git pull origin main

# Create tag
git tag v1.0.0
git push origin v1.0.0
```

## Pull Requests
```bash
# List pull requests
az repos pr list --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Create pull request
az repos pr create --title "Implement new feature" --description "Adds new functionality" --source-branch feature-branch --target-branch main --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Show pull request
az repos pr show --id 1 --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Update pull request
az repos pr update --id 1 --title "Updated title" --description "Updated description" --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Set reviewers
az repos pr reviewer add --id 1 --reviewers user1@domain.com user2@domain.com --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Approve pull request
az repos pr set-vote --id 1 --vote approve --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Complete pull request
az repos pr update --id 1 --status completed --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg
```

## Branches
```bash
# List branches
az repos ref list --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Create branch
az repos ref create --name refs/heads/feature-branch --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Delete branch
az repos ref delete --name refs/heads/old-branch --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg --yes
```

## Policies
```bash
# List branch policies
az repos policy list --repository "my-repo" --branch main --project "My Project" --organization https://dev.azure.com/myorg

# Create build policy
az repos policy build create --repository "my-repo" --branch main --build-definition-id 1 --project "My Project" --organization https://dev.azure.com/myorg

# Create required reviewer policy
az repos policy required-reviewer create --repository "my-repo" --branch main --required-reviewer-ids <user-id> --project "My Project" --organization https://dev.azure.com/myorg
```

## Commits and History
```bash
# List commits
az repos commit list --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Show commit
az repos commit show --commit-id <commit-id> --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Get commit diff
az repos commit diff --commit-id <commit-id> --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg
```

## Forks
```bash
# Create fork
az repos fork create --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg --fork-to-project "Fork Project"

# List forks
az repos fork list --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg
```

## Import/Export
```bash
# Import repository
az repos import create --git-source-url https://github.com/user/repo.git --repository "imported-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Export repository (via Git)
git clone --mirror https://dev.azure.com/myorg/My%20Project/_git/my-repo
```

## Webhooks
```bash
# List webhooks
az repos webhook list --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg

# Create webhook
az repos webhook create --name "Push Webhook" --repository "my-repo" --project "My Project" --organization https://dev.azure.com/myorg --event push --url https://my-webhook-url.com --http-headers "Content-Type=application/json"
```

## Best Practices
- Use meaningful commit messages
- Implement branch policies for main branch
- Require pull request reviews
- Use feature branches for development
- Keep repositories organized with proper naming
- Set up branch protection rules
- Use tags for releases
- Implement CI/CD integration
- Regularly clean up old branches
- Use squash merges for cleaner history