# Azure Kubernetes Service (AKS) Concepts

## Overview
Azure Kubernetes Service (AKS) is a managed Kubernetes service that simplifies deploying, managing, and scaling containerized applications in Azure. It provides serverless Kubernetes, integrated CI/CD, and enterprise-grade security.

## Key Concepts

### 1. AKS Architecture

#### Control Plane
Managed by Azure, includes:
- **API Server:** Entry point for management
- **etcd:** Key-value store for cluster data
- **Scheduler:** Assigns pods to nodes
- **Controller Manager:** Runs controllers

#### Node Pools
Groups of nodes with same configuration.

**Types:**
- **System Node Pool:** Runs critical system pods
- **User Node Pools:** Run application workloads

#### Nodes
Virtual machines running containerized applications.

### 2. Cluster Creation and Configuration

#### Basic Cluster Creation
```bash
az aks create \
  --resource-group myRG \
  --name myAKSCluster \
  --node-count 3 \
  --enable-addons monitoring \
  --generate-ssh-keys
```

#### Advanced Configuration
- **Network Plugin:** Azure CNI vs Kubenet
- **Node Size:** VM SKU selection
- **OS Type:** Linux vs Windows
- **Kubernetes Version:** Version selection

### 3. Networking

#### Azure CNI
Each pod gets IP from Azure subnet.

**Benefits:**
- Pod IPs routable in Azure network
- No NAT required
- Better network performance

#### Kubenet
Pods use different address space than nodes.

**Benefits:**
- Simpler setup
- Fewer IP addresses required

#### Network Policies
Control traffic between pods.

**Example Network Policy:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-web
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: api
    ports:
    - protocol: TCP
      port: 80
```

### 4. Storage

#### Azure Disk
Block storage for pods.

**Types:**
- **Standard HDD/SSD**
- **Premium SSD**
- **Ultra Disk**

#### Azure Files
File shares for pods.

#### Blob Storage
Object storage integration.

**Example Persistent Volume Claim:**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: azure-disk-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: managed-premium
  resources:
    requests:
      storage: 5Gi
```

### 5. Security

#### Azure Active Directory Integration
Authenticate users with AAD.

#### Azure Policy
Enforce governance on clusters.

#### Pod Security Standards
Define security contexts for pods.

**Example Security Context:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 1000
    fsGroup: 1000
  containers:
  - name: app
    image: myapp:latest
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      runAsNonRoot: true
      capabilities:
        drop:
        - ALL
```

### 6. Scaling

#### Manual Scaling
```bash
# Scale node count
az aks scale --resource-group myRG --name myAKSCluster --node-count 5

# Scale specific node pool
az aks nodepool scale --resource-group myRG --cluster-name myAKSCluster --name nodepool1 --node-count 3
```

#### Cluster Autoscaler
Automatically adjust node count based on resource requests.

**Enable Autoscaler:**
```bash
az aks update \
  --resource-group myRG \
  --name myAKSCluster \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 10
```

#### Horizontal Pod Autoscaler
Scale pods based on CPU/memory usage.

**Example HPA:**
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: web-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web-deployment
  minReplicas: 1
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

### 7. Monitoring and Logging

#### Azure Monitor for Containers
Integrated monitoring solution.

**Features:**
- **Container Insights:** Performance metrics
- **Live Data:** Real-time container logs
- **Workbooks:** Custom dashboards

#### Azure Log Analytics
Centralized logging.

**Example Query:**
```kusto
ContainerLog
| where Name contains "error"
| summarize count() by bin(TimeGenerated, 1h)
```

### 8. DevOps Integration

#### Azure DevOps
CI/CD pipelines for AKS.

#### GitOps
Flux or ArgoCD for Git-based deployments.

**Example Flux Configuration:**
```yaml
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: GitRepository
metadata:
  name: app-repo
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
  name: app-kustomization
  namespace: flux-system
spec:
  interval: 5m
  path: "./kustomize"
  prune: true
  sourceRef:
    kind: GitRepository
    name: app-repo
```

### 9. Upgrades and Maintenance

#### Cluster Upgrades
```bash
# Check available versions
az aks get-upgrades --resource-group myRG --name myAKSCluster

# Upgrade cluster
az aks upgrade --resource-group myRG --name myAKSCluster --kubernetes-version 1.24.0
```

#### Node Image Upgrades
Apply latest OS security patches.

```bash
az aks nodepool upgrade \
  --resource-group myRG \
  --cluster-name myAKSCluster \
  --name nodepool1 \
  --node-image-only
```

### 10. Cost Optimization

#### Azure Reservations
Discounted pricing for committed usage.

#### Spot Instances
Use preemptible VMs for non-critical workloads.

**Example Spot Node Pool:**
```bash
az aks nodepool add \
  --resource-group myRG \
  --cluster-name myAKSCluster \
  --name spotpool \
  --node-count 3 \
  --priority Spot \
  --eviction-policy Delete \
  --spot-max-price -1 \
  --node-vm-size Standard_DS2_v2
```

#### Cluster Autoscaler
Right-size cluster based on demand.

## Real Project Examples

### Multi-Tier Application Deployment
```yaml
# Frontend Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: frontend
        image: myregistry.azurecr.io/frontend:v1.0
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 200m
            memory: 256Mi

---
# Backend Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
      - name: backend
        image: myregistry.azurecr.io/backend:v1.0
        ports:
        - containerPort: 8080
        env:
        - name: DB_CONNECTION
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: connection-string

---
# Services
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  selector:
    app: frontend
  ports:
  - port: 80
    targetPort: 80
  type: LoadBalancer

---
apiVersion: v1
kind: Service
metadata:
  name: backend-service
spec:
  selector:
    app: backend
  ports:
  - port: 8080
    targetPort: 8080
  type: ClusterIP
```

### CI/CD Pipeline for AKS
```yaml
# Azure DevOps Pipeline
stages:
- stage: Build
  jobs:
  - job: Build
    steps:
    - task: Docker@2
      inputs:
        command: 'buildAndPush'
        repository: 'myapp'
        dockerfile: 'Dockerfile'
        containerRegistry: 'myacr'
        tags: |
          $(Build.BuildId)
          latest

- stage: Deploy
  jobs:
  - deployment: Deploy
    environment: 'production'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: Kubernetes@1
            inputs:
              connectionType: 'Azure Resource Manager'
              azureSubscriptionEndpoint: 'my-subscription'
              azureResourceGroup: 'myRG'
              kubernetesCluster: 'myAKSCluster'
              namespace: 'default'
              command: 'apply'
              useConfigurationFile: true
              configurationFile: 'k8s/deployment.yml'
              secretType: 'dockerRegistry'
              containerRegistryType: 'Azure Container Registry'
```

### Monitoring Setup
```yaml
# Prometheus ServiceMonitor
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: myapp-monitor
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: myapp
  endpoints:
  - port: metrics
    path: /metrics
    interval: 30s

---
# Grafana Dashboard ConfigMap
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-dashboard
  namespace: monitoring
data:
  dashboard.json: |
    {
      "dashboard": {
        "title": "Application Metrics",
        "panels": [
          {
            "title": "Request Rate",
            "type": "graph",
            "targets": [
              {
                "expr": "rate(http_requests_total[5m])",
                "legendFormat": "Requests/sec"
              }
            ]
          }
        ]
      }
    }
```

### Security Hardening
```yaml
# Pod Security Policy (deprecated, use Pod Security Standards)
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: restricted
spec:
  privileged: false
  allowPrivilegeEscalation: false
  requiredDropCapabilities:
    - ALL
  runAsUser:
    rule: 'MustRunAsNonRoot'
  seLinux:
    rule: 'RunAsAny'
  supplementalGroups:
    rule: 'MustRunAs'
    ranges:
    - min: 1
      max: 65535
  fsGroup:
    rule: 'MustRunAs'
    ranges:
    - min: 1
      max: 65535
  readOnlyRootFilesystem: true

---
# Network Policy for Zero Trust
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: zero-trust
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          name: ingress-nginx
    ports:
    - protocol: TCP
      port: 80
    - protocol: TCP
      port: 443
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          name: kube-system
    ports:
    - protocol: UDP
      port: 53
  - to: []
    ports:
    - protocol: TCP
      port: 443
```

## Best Practices
- Use Azure CNI for better networking performance
- Implement proper resource requests and limits
- Use Azure Monitor for comprehensive monitoring
- Implement network policies for security
- Use managed identities for authentication
- Enable cluster autoscaling for cost optimization
- Implement proper backup and disaster recovery
- Use Azure Policy for governance
- Regularly update cluster and node images
- Implement proper logging and tracing