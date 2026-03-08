# Azure DevOps Engineer Expert (AZ-400) Concepts

## Overview
Azure DevOps Engineer Expert (AZ-400) certification focuses on designing and implementing DevOps practices using Azure technologies. It covers CI/CD, infrastructure as code, security, and monitoring.

## Key Concepts

### 1. DevOps Principles

#### Continuous Integration (CI)
Frequent code integration and automated testing.

**Key Practices:**
- Automated builds
- Unit testing
- Code quality gates
- Early feedback

#### Continuous Delivery (CD)
Automated deployment to various environments.

**Key Practices:**
- Environment consistency
- Automated testing
- Rollback strategies
- Deployment approvals

#### Continuous Deployment
Automatic deployment to production after successful tests.

### 2. Azure DevOps Services

#### Azure Repos
Git repositories with advanced features.

**Features:**
- Branch policies
- Pull request reviews
- Code search
- Wiki integration

#### Azure Pipelines
CI/CD pipeline automation.

**Key Components:**
- Agents and agent pools
- YAML pipelines
- Pipeline templates
- Multi-stage pipelines

#### Azure Boards
Work item tracking and agile planning.

**Features:**
- Work item types
- Kanban boards
- Sprint planning
- Reporting

#### Azure Test Plans
Manual and exploratory testing.

#### Azure Artifacts
Package management.

### 3. Infrastructure as Code (IaC)

#### ARM Templates
JSON-based resource definition.

**Best Practices:**
- Modular templates
- Parameter files
- Template specs
- Linked templates

#### Azure Bicep
Domain-specific language for ARM templates.

**Example:**
```bicep
param location string = 'eastus'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'mystorageaccount'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
```

#### Terraform
Multi-cloud IaC tool.

### 4. Containerization and Orchestration

#### Docker
Container platform.

**Concepts:**
- Dockerfile best practices
- Multi-stage builds
- Docker Compose
- Image security scanning

#### Azure Container Registry (ACR)
Managed container registry.

**Features:**
- Geo-replication
- Image scanning
- Token-based authentication

#### Azure Kubernetes Service (AKS)
Managed Kubernetes service.

**Advanced Features:**
- Cluster autoscaling
- Azure Policy integration
- GitOps with Flux
- Service Mesh (Istio)

### 5. Security and Compliance

#### Azure Key Vault
Secrets management.

**Integration:**
- VM extensions
- App Service
- AKS pods

#### Azure Policy
Governance and compliance.

**Policy Effects:**
- Deny
- Audit
- Append
- Modify

#### DevSecOps
Security in DevOps.

**Practices:**
- SAST (Static Application Security Testing)
- DAST (Dynamic Application Security Testing)
- Container scanning
- Dependency scanning

### 6. Monitoring and Observability

#### Azure Monitor
Comprehensive monitoring.

**Components:**
- Application Insights
- Log Analytics
- Metrics
- Alerts

#### Azure Application Insights
Application performance monitoring.

**Features:**
- Request tracing
- Dependency tracking
- Custom metrics
- Smart detection

#### Distributed Tracing
Track requests across services.

### 7. Deployment Strategies

#### Blue-Green Deployment
Two identical environments.

**Process:**
1. Deploy to blue environment
2. Test blue environment
3. Switch traffic to blue
4. Keep green as rollback option

#### Canary Deployment
Gradual rollout to subset of users.

**Implementation:**
- Traffic splitting
- Feature flags
- Monitoring metrics

#### A/B Testing
Compare different versions.

### 8. GitOps

#### Principles
- Declarative configuration
- Version control as source of truth
- Automated deployment
- Observability

#### Tools
- Flux
- ArgoCD
- Azure Arc

### 9. Site Reliability Engineering (SRE)

#### Service Level Objectives (SLOs)
Target performance levels.

**Example:**
- Availability: 99.9% uptime
- Latency: P95 < 500ms

#### Error Budgets
Allowed downtime/unreliability.

#### Incident Management
- Incident response
- Post-mortem analysis
- Blameless culture

### 10. Advanced Networking

#### Azure Front Door
Global load balancer.

**Features:**
- Global distribution
- WAF integration
- SSL termination

#### Azure Traffic Manager
DNS-based traffic routing.

#### Virtual WAN
Global network connectivity.

## Real Project Examples

### Multi-Stage Pipeline with Approvals
```yaml
stages:
- stage: Build
  jobs:
  - job: Build
    steps:
    - task: DotNetCoreCLI@2
      inputs:
        command: 'build'
        projects: '**/*.csproj'

- stage: Dev
  jobs:
  - deployment: DeployDev
    environment: 'dev'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: AzureWebApp@1
            inputs:
              azureSubscription: 'dev-subscription'
              appName: 'myapp-dev'

- stage: Staging
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
  jobs:
  - deployment: DeployStaging
    environment: 'staging'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: AzureWebApp@1
            inputs:
              azureSubscription: 'staging-subscription'
              appName: 'myapp-staging'

- stage: Production
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
  jobs:
  - deployment: DeployProd
    environment: 'production'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: AzureWebApp@1
            inputs:
              azureSubscription: 'prod-subscription'
              appName: 'myapp-prod'
```

### Infrastructure as Code with Bicep
```bicep
param environment string = 'dev'
param location string = resourceGroup().location

var appName = 'myapp-${environment}'
var planName = 'plan-${environment}'

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: planName
  location: location
  sku: {
    name: environment == 'prod' ? 'P1V2' : 'B1'
  }
}

resource webApp 'Microsoft.Web/sites@2020-12-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: 'kv-${appName}'
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: []
  }
}

output webAppUrl string = 'https://${webApp.name}.azurewebsites.net'
```

### GitOps with Flux
```yaml
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: GitRepository
metadata:
  name: myapp
  namespace: flux-system
spec:
  interval: 1m
  url: https://github.com/myorg/myapp
  ref:
    branch: main

---
apiVersion: kustomize.toolkit.fluxcd.io/v1beta2
kind: Kustomization
metadata:
  name: myapp
  namespace: flux-system
spec:
  interval: 5m
  path: "./kustomize"
  prune: true
  sourceRef:
    kind: GitRepository
    name: myapp
  validation: client
```

## Best Practices
- Implement comprehensive CI/CD pipelines
- Use infrastructure as code for all environments
- Implement security scanning in pipelines
- Use feature flags for gradual rollouts
- Implement proper monitoring and alerting
- Use GitOps for Kubernetes deployments
- Implement proper backup and disaster recovery
- Use Azure Policy for governance
- Implement cost optimization strategies
- Foster DevOps culture and collaboration