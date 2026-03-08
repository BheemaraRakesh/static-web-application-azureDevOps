# Jira Concepts

## Overview
Jira is a project management and issue tracking tool developed by Atlassian. It's widely used for agile development, bug tracking, and workflow management in software development teams.

## Key Concepts

### 1. Projects

#### Project Types
- **Software Development:** For agile/scrum teams
- **Business/Project Management:** For general project tracking
- **Service Desk:** For customer support
- **Kanban:** For continuous flow work

#### Project Configuration
- **Issue Types:** Bug, Task, Story, Epic, etc.
- **Workflows:** Define issue lifecycle
- **Screens:** Customize fields for different operations
- **Permissions:** Control access and actions

### 2. Issues

#### Issue Types
- **Epic:** Large body of work broken into smaller tasks
- **Story:** User-focused functionality
- **Task:** General work item
- **Bug:** Software defect
- **Sub-task:** Smaller work item under a parent

#### Issue Fields
- **Summary:** Brief description
- **Description:** Detailed information
- **Priority:** Blocker, Critical, Major, Minor, Trivial
- **Assignee:** Person responsible
- **Reporter:** Person who created the issue
- **Labels:** Custom tags
- **Components:** Subsections of project
- **Fix Version:** Release version

### 3. Workflows

#### Workflow Components
- **Statuses:** To Do, In Progress, Done, etc.
- **Transitions:** Movement between statuses
- **Validators:** Check conditions before transition
- **Post Functions:** Actions after transition
- **Conditions:** Control who can perform transitions

#### Example Workflow
```
Open → In Progress → In Review → Resolved → Closed
     ↓         ↓
  Rejected  Failed Review
```

### 4. Agile Boards

#### Scrum Board
- **Sprints:** Time-boxed iterations
- **Backlog:** Prioritized work items
- **Sprint Planning:** Select work for sprint
- **Daily Standups:** Track progress
- **Sprint Review:** Demonstrate work
- **Sprint Retrospective:** Improve process

#### Kanban Board
- **Columns:** Represent workflow stages
- **Work In Progress (WIP) Limits:** Control concurrent work
- **Continuous Flow:** No time-boxed iterations

### 5. Dashboards and Reporting

#### Gadgets
- **Issue Statistics:** Count by various criteria
- **Pie Charts:** Visual representation of data
- **Two Dimensional Filter Statistics:** Cross-tabulation
- **Filter Results:** List issues matching filter

#### Reports
- **Burndown Chart:** Sprint progress
- **Velocity Chart:** Team velocity over time
- **Control Chart:** Cycle time analysis
- **Cumulative Flow Diagram:** Work flow visualization

### 6. JQL (Jira Query Language)

#### Basic Queries
```jql
# Find all bugs
issuetype = Bug

# Find issues assigned to user
assignee = currentUser()

# Find issues in project
project = "My Project"

# Find high priority issues
priority = High
```

#### Advanced Queries
```jql
# Issues created in last week
created > -1w

# Issues updated in last 24 hours
updated > -1d

# Issues with specific labels
labels in (urgent, blocker)

# Issues in sprint
sprint in openSprints()

# Complex query with AND/OR
project = "Web App" AND (issuetype = Bug OR issuetype = Story) AND status != Closed
```

### 7. Permissions and Security

#### Permission Schemes
Control what users can do with issues.

**Common Permissions:**
- **Browse Projects:** View project
- **Create Issues:** Add new issues
- **Edit Issues:** Modify issues
- **Delete Issues:** Remove issues
- **Assign Issues:** Change assignees

#### Security Levels
Restrict issue visibility.

### 8. Integrations

#### Development Tools
- **Bitbucket/GitHub:** Source code integration
- **Jenkins/Bamboo:** CI/CD integration
- **Confluence:** Documentation linking

#### Communication Tools
- **Slack/Microsoft Teams:** Notifications
- **Email:** Issue updates

### 9. Automation

#### Automation Rules
Trigger actions based on events.

**Example Rules:**
- When issue is created → Assign to team lead
- When issue is resolved → Send notification
- When sprint ends → Generate report

#### Smart Values
Dynamic content in notifications and updates.

### 10. Advanced Features

#### Custom Fields
Add project-specific fields.

#### Webhooks
Send HTTP requests on events.

#### REST API
Programmatic access to Jira data.

## Real Project Examples

### Scrum Process Setup
1. **Create Project:** Choose Scrum template
2. **Configure Issue Types:** Epic, Story, Bug, Task
3. **Set Up Board:** Create Scrum board with columns
4. **Create Epics:** Break down major features
5. **Plan Sprint:** Select stories for 2-week sprint
6. **Daily Standups:** Update progress daily
7. **Sprint Review:** Demonstrate completed work
8. **Retrospective:** Identify improvements

### Bug Tracking Workflow
```
Reported → Triaged → In Development → Code Review → Testing → Resolved
     ↓         ↓            ↓              ↓          ↓
  Duplicate  Won't Fix   Blocked       Failed     Reopened
```

### Kanban for Support Team
- **Backlog:** New requests
- **To Do:** Acknowledged issues
- **In Progress:** Being worked on
- **Waiting:** Awaiting customer response
- **Done:** Resolved issues

### Dashboard Configuration
**Common Dashboard Setup:**
- Sprint Burndown Chart
- Velocity Chart
- Issue Statistics by Status
- Recent Activity Stream
- Assigned to Me gadget
- Filter Results for urgent issues

### JQL Examples for Reporting
```jql
# Open bugs by priority
project = "My Project" AND issuetype = Bug AND status != Closed ORDER BY priority DESC

# Issues completed this month
project = "My Project" AND resolved >= startOfMonth() AND resolved <= endOfMonth()

# Overdue issues
project = "My Project" AND duedate < now() AND status != Closed

# Team workload
project = "My Project" AND assignee in (john, jane, bob) AND status != Closed
```

### Automation Rule Example
**When issue is created:**
- If issue type is "Bug" → Set priority to "Major"
- If reporter is external → Add "external" label
- Send Slack notification to dev team

**When issue transitions to "Done":**
- If issue type is "Story" → Update story points in Confluence
- Send email to product owner
- Create follow-up task for documentation

## Best Practices
- Use consistent naming conventions
- Implement proper workflow validation
- Set up appropriate permission schemes
- Use labels and components for organization
- Implement automation to reduce manual work
- Create informative dashboards
- Use JQL for advanced searching and reporting
- Integrate with development tools
- Train team on Jira usage
- Regularly review and optimize workflows