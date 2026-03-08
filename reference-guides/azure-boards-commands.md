# Azure Boards Commands Reference

Commands for managing work items, boards, and agile processes in Azure DevOps Boards.

## Work Items
```bash
# Create work item
az boards work-item create --title "Implement login feature" --type "User Story" --project "My Project" --organization https://dev.azure.com/myorg

# Update work item
az boards work-item update --id 123 --title "Updated title" --project "My Project" --organization https://dev.azure.com/myorg

# Show work item
az boards work-item show --id 123 --project "My Project" --organization https://dev.azure.com/myorg

# Delete work item
az boards work-item delete --id 123 --project "My Project" --organization https://dev.azure.com/myorg --yes

# Query work items
az boards query --wiql "SELECT [System.Id] FROM WorkItems WHERE [System.WorkItemType] = 'Bug' AND [System.State] = 'Active'" --project "My Project" --organization https://dev.azure.com/myorg
```

## Areas and Iterations
```bash
# List areas
az boards area list --project "My Project" --organization https://dev.azure.com/myorg

# Create area
az boards area create --name "Web" --project "My Project" --organization https://dev.azure.com/myorg

# List iterations
az boards iteration list --project "My Project" --organization https://dev.azure.com/myorg

# Create iteration
az boards iteration create --name "Sprint 1" --project "My Project" --organization https://dev.azure.com/myorg --start-date 2024-01-01 --finish-date 2024-01-14
```

## Team Management
```bash
# List teams
az devops team list --project "My Project" --organization https://dev.azure.com/myorg

# Create team
az devops team create --name "Backend Team" --project "My Project" --organization https://dev.azure.com/myorg

# Add team member
az devops team member add --team "Backend Team" --user user@domain.com --project "My Project" --organization https://dev.azure.com/myorg
```

## Board Configuration
```bash
# List boards
az boards board list --project "My Project" --organization https://dev.azure.com/myorg

# Update board column
az boards board column update --board "Stories" --column "In Progress" --name "In Development" --project "My Project" --organization https://dev.azure.com/myorg
```

## Process Templates
```bash
# List processes
az devops process list --organization https://dev.azure.com/myorg

# Create inherited process
az devops process create --name "My Custom Process" --description "Custom agile process" --base-process-id <base-process-id> --organization https://dev.azure.com/myorg
```

## Backlogs and Sprints
```bash
# Get backlog items
az boards backlog item list --backlog "Stories" --project "My Project" --organization https://dev.azure.com/myorg

# Move work item to sprint
az boards work-item update --id 123 --fields "System.IterationPath=My Project\\Sprint 1" --project "My Project" --organization https://dev.azure.com/myorg
```

## Reporting
```bash
# Get team capacity
az boards iteration teamcapacity list --iteration-id <iteration-id> --team "My Team" --project "My Project" --organization https://dev.azure.com/myorg

# Update team capacity
az boards iteration teamcapacity update --iteration-id <iteration-id> --team "My Team" --user-id <user-id> --capacity-per-day 8 --project "My Project" --organization https://dev.azure.com/myorg
```

## Best Practices
- Use consistent naming conventions for work items
- Set up proper area paths for organization
- Configure iterations in advance
- Use tags for categorization
- Set up team capacity for sprint planning
- Use queries for reporting and tracking
- Implement work item templates
- Regularly groom backlogs
- Use boards for visual management
- Integrate with Git commits and PRs