# Kubernetes Commands Reference

Essential kubectl commands for managing Kubernetes clusters and applications in production.

## Cluster Information
```bash
# Get cluster info
kubectl cluster-info

# Get API server version
kubectl version --short

# View cluster events
kubectl get events --sort-by=.metadata.creationTimestamp

# Get all resources
kubectl get all --all-namespaces
```

## Nodes
```bash
# List nodes
kubectl get nodes

# Describe node
kubectl describe node <node-name>

# Get node capacity and usage
kubectl get nodes --output json | jq '.items[] | {name: .metadata.name, capacity: .status.capacity, usage: .status.allocatable}'

# Cordon node (prevent scheduling)
kubectl cordon <node-name>

# Uncordon node
kubectl uncordon <node-name>

# Drain node (evict pods)
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
```

## Namespaces
```bash
# List namespaces
kubectl get namespaces

# Create namespace
kubectl create namespace production

# Set default namespace
kubectl config set-context --current --namespace=production

# Delete namespace
kubectl delete namespace test-namespace
```

## Pods
```bash
# List pods
kubectl get pods

# List pods with wide output
kubectl get pods -o wide

# Describe pod
kubectl describe pod <pod-name>

# Get pod logs
kubectl logs <pod-name>

# Get logs from previous container
kubectl logs <pod-name> --previous

# Follow logs
kubectl logs -f <pod-name>

# Execute command in pod
kubectl exec -it <pod-name> -- /bin/bash

# Copy files to/from pod
kubectl cp <pod-name>:/path/to/file ./local-file

# Delete pod
kubectl delete pod <pod-name>

# Force delete pod
kubectl delete pod <pod-name> --force --grace-period=0
```

## Deployments
```bash
# List deployments
kubectl get deployments

# Describe deployment
kubectl describe deployment <deployment-name>

# Scale deployment
kubectl scale deployment <deployment-name> --replicas=5

# Update image
kubectl set image deployment/<deployment-name> <container-name>=<new-image>

# Rollback deployment
kubectl rollout undo deployment/<deployment-name>

# Check rollout status
kubectl rollout status deployment/<deployment-name>

# Pause rollout
kubectl rollout pause deployment/<deployment-name>

# Resume rollout
kubectl rollout resume deployment/<deployment-name>

# View rollout history
kubectl rollout history deployment/<deployment-name>
```

## Services
```bash
# List services
kubectl get services

# Describe service
kubectl describe service <service-name>

# Get service endpoints
kubectl get endpoints

# Create service
kubectl expose deployment <deployment-name> --type=LoadBalancer --port=80 --target-port=8080
```

## ConfigMaps and Secrets
```bash
# List ConfigMaps
kubectl get configmaps

# Create ConfigMap from file
kubectl create configmap myconfig --from-file=config.properties

# List secrets
kubectl get secrets

# Create secret
kubectl create secret generic mysecret --from-literal=key=value

# View secret (decoded)
kubectl get secret mysecret -o jsonpath='{.data.key}' | base64 --decode
```

## Jobs and CronJobs
```bash
# List jobs
kubectl get jobs

# Create job
kubectl create job myjob --image=busybox -- echo "Hello World"

# List cronjobs
kubectl get cronjobs

# Create cronjob
kubectl create cronjob mycronjob --image=busybox --schedule="0 0 * * *" -- echo "Daily backup"
```

## Ingress
```bash
# List ingresses
kubectl get ingress

# Describe ingress
kubectl describe ingress <ingress-name>
```

## Persistent Volumes
```bash
# List PVs
kubectl get pv

# List PVCs
kubectl get pvc

# Describe PVC
kubectl describe pvc <pvc-name>
```

## RBAC
```bash
# List service accounts
kubectl get serviceaccounts

# Create service account
kubectl create serviceaccount my-sa

# List roles
kubectl get roles

# List cluster roles
kubectl get clusterroles

# Create role binding
kubectl create rolebinding my-binding --role=my-role --serviceaccount=default:my-sa
```

## Troubleshooting
```bash
# Check pod status
kubectl get pods --field-selector=status.phase!=Running

# Debug with temporary pod
kubectl run debug-pod --image=busybox --rm -it --restart=Never -- sh

# Check resource usage
kubectl top nodes
kubectl top pods

# View cluster events
kubectl get events --field-selector type=Warning

# Check API server logs (if accessible)
kubectl logs -n kube-system kube-apiserver-<node-name>
```

## Helm (if using Helm)
```bash
# Install Helm chart
helm install myrelease ./mychart

# Upgrade release
helm upgrade myrelease ./mychart

# List releases
helm list

# Uninstall release
helm uninstall myrelease
```

## Best Practices
- Use `kubectl apply -f` for declarative management
- Use `kubectl diff` to preview changes
- Set resource limits and requests
- Use labels and selectors for organization
- Implement health checks (readiness and liveness probes)
- Use secrets for sensitive data
- Regularly check resource usage and events
- Use `kubectl --dry-run=client` for testing