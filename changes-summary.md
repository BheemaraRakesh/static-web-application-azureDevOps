# Summary of Changes Made to Fix Pipeline and Deployment

## Files Created/Modified

### 1. `azure-pipelines.yml` (New File)
- **Purpose**: Azure DevOps pipeline YAML for CI/CD to AKS.
- **Key Stages**:
  - **Build**: Login to ACR, build Docker image, push to ACR.
  - **Deploy**: Checkout repo, get AKS credentials, apply Kubernetes manifests.
- **Fixes Applied**:
  - Used `AzureCLI@2` for ACR login and kubectl apply instead of `Kubernetes@1` task to avoid file path issues.
  - Added `checkout: self` in Deploy stage to ensure manifests are available.
  - Explicitly applied manifests from `manifests/` directory.

### 2. `manifests/deployment.yaml` (New File)
- **Purpose**: Kubernetes Deployment for the static app.
- **Details**:
  - Replicas: 2
  - Image: `mycontainerregistry0103.azurecr.io/static-app:latest`
  - Ports: Container port 80
  - Labels: `app: hello-web`

### 3. `manifests/service.yaml` (New File)
- **Purpose**: Kubernetes Service to expose the app externally.
- **Details**:
  - Type: LoadBalancer
  - Selector: `app: hello-web`
  - Ports: 80 (external) -> 80 (container)

### 4. `pipeline-backup.yml` (New File)
- **Purpose**: Backup of the previous pipeline configuration using `Kubernetes@1` task.
- **Use**: For reference or restoration if needed.

## Commands Executed to Fix Issues

### 1. Attach ACR to AKS
- **Command**: `az aks update --resource-group Kubernetes-Learning --name dryrun-cluster --attach-acr mycontainerregistry0103`
- **Reason**: Granted AKS permission to pull images from the private ACR, fixing `ErrImagePull` on pods.

### 2. Get AKS Credentials
- **Command**: `az aks get-credentials --resource-group Kubernetes-Learning --name dryrun-cluster --overwrite-existing`
- **Reason**: Allowed kubectl commands to interact with the cluster.

## Issues Resolved

1. **Git Push Authentication**: Resolved by using Personal Access Token (PAT) or credential manager.
2. **Docker Push Unauthorized**: Fixed by using `az acr login` in pipeline and ensuring correct tagging.
3. **Pipeline Deploy Failure**: Switched from `Kubernetes@1` task to `AzureCLI@2` with `kubectl apply -f manifests/`.
4. **Pods ErrImagePull**: Attached ACR to AKS for image pull permissions.
5. **504 Gateway Error**: Resolved once pods were running and accessible via LoadBalancer.

## Final Result
- Pipeline runs successfully: Builds image, pushes to ACR, deploys to AKS.
- App accessible at external IP (e.g., `http://4.188.97.0`) without errors.
- Pods: 2 replicas running.
- Service: LoadBalancer with external IP.

## Notes
- Update variables in `azure-pipelines.yml` (e.g., resource group, cluster name) to match your setup.
- Ensure Azure DevOps service connections are configured for ARM and ACR access.