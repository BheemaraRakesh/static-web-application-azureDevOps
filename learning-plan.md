# Learning Plan for Static App Project

This document outlines the requirements and key topics to cover for gaining production-level knowledge from the static-app project. The project demonstrates a complete DevOps pipeline for deploying a static website to Azure Kubernetes Service (AKS).

## Prerequisites

### Accounts and Access
- Azure subscription with permissions to create resources (AKS, ACR, VMs, etc.)
- Azure DevOps organization and project
- GitHub or Azure Repos for source control
- Personal Access Token (PAT) for Azure DevOps authentication

### Tools and Software
- Docker Desktop or Docker CLI
- kubectl (Kubernetes CLI)
- Azure CLI (az)
- Git
- A code editor (e.g., VS Code)
- Node.js/npm (if extending with build tools, though not required here)

### Knowledge Base
- Basic understanding of HTML, CSS, and JavaScript
- Familiarity with command-line interfaces (Bash/Linux)
- Basic networking concepts (ports, load balancers)

## Technologies Used

### Frontend
- HTML5
- CSS3
- JavaScript (ES6+)

### Containerization
- Docker
- Nginx (as web server)

### Orchestration
- Kubernetes
  - Deployments
  - Services (LoadBalancer type)
  - Pods and replicas

### Cloud Platform
- Microsoft Azure
  - Azure Kubernetes Service (AKS)
  - Azure Container Registry (ACR)
  - Azure Resource Groups
  - Azure Virtual Networks (VNet)
  - Network Security Groups (NSG)
  - Virtual Machines (VMs)

### CI/CD
- Azure DevOps Pipelines
  - YAML-based pipeline configuration
  - Multi-stage pipelines (Build and Deploy)
  - Azure CLI tasks

### Infrastructure Automation
- Shell scripting (Bash)
- Azure CLI commands for resource provisioning

### Version Control
- Git
- Branching strategies (e.g., master/main branch triggers)

## Key Concepts to Learn

### 1. Static Website Development
- Creating responsive web pages with HTML/CSS/JS
- Implementing auto-refresh and client-side logging
- Best practices for static site structure and deployment

### 2. Containerization
- Writing Dockerfiles for web applications
- Using base images (e.g., nginx:alpine)
- Building, tagging, and pushing Docker images
- Container registries (ACR) and image management

### 3. Kubernetes Fundamentals
- Understanding Kubernetes objects: Pods, Deployments, Services
- YAML manifest files for deployments
- LoadBalancer services for external access
- Scaling applications with replicas
- Troubleshooting pod issues (e.g., ErrImagePull)

### 4. Azure Cloud Services
- Resource group management
- AKS cluster creation and configuration
- ACR setup and integration with AKS
- Networking concepts: VNets, NSGs, public IPs
- VM provisioning and management

### 5. CI/CD Pipelines
- Azure DevOps pipeline structure (stages, jobs, steps)
- Triggering pipelines on git pushes
- Using Azure CLI in pipelines for authentication and deployment
- Debugging pipeline failures

### 6. Infrastructure as Code (IaC)
- Writing shell scripts for Azure resource provisioning
- Using Azure CLI for declarative infrastructure changes
- Managing secrets and credentials securely

### 7. DevOps Practices
- Version control workflows
- Automated testing (though not implemented here, understand the concept)
- Monitoring and logging (basic console logs, extend to Azure Monitor)
- Security best practices (ACR permissions, network security)
- Troubleshooting deployment issues

### 8. Production Considerations
- High availability with multiple replicas
- Load balancing and traffic distribution
- Cost optimization in Azure
- Backup and disaster recovery basics
- Compliance and governance

## Learning Path

1. **Start with Basics**: Learn HTML/CSS/JS and create a simple static site
2. **Containerize**: Understand Docker and create containerized applications
3. **Orchestrate**: Study Kubernetes concepts and deploy to local clusters (e.g., Minikube)
4. **Cloud Deployment**: Set up Azure account and learn core services (AKS, ACR)
5. **Automation**: Learn Azure CLI and shell scripting for infrastructure
6. **CI/CD**: Build pipelines with Azure DevOps
7. **Advanced Topics**: Monitoring, security, scaling, and optimization

## Resources for Learning

- [Docker Documentation](https://docs.docker.com/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Azure Documentation](https://docs.microsoft.com/en-us/azure/)
- [Azure DevOps Documentation](https://docs.microsoft.com/en-us/azure/devops/)
- [Azure CLI Reference](https://docs.microsoft.com/en-us/cli/azure/)
- FreeCodeCamp, Pluralsight, or Udemy courses on DevOps and cloud

## Next Steps

- Set up a free Azure account and try provisioning resources
- Deploy the app locally with Docker
- Experiment with Kubernetes on Minikube
- Customize the pipeline for your own projects
- Add features like HTTPS, monitoring, or database integration