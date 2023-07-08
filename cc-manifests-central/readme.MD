# Happy Web Services

### How to Deploy Happy Services  
This guide explains the steps to deploy the "Happy" application to a Kubernetes cluster using Kustomization. The deployment consists of a `deployment` manifest for the application's pods and a `service` manifest to expose the application internally.

### Requirement
1. Kubernetes cluster that is already running and accessible.
2. kubectl installed and configured to access the cluster.
3. Deployment and service Kubernetes manifest.
4. Kustomize installed (version 3 or later)

### Deployment Steps
1. Clone the repository
```bash
git clone <repository-url>
```

2. Navigate to the application's directory
```bash
cd Happy-Web-Service
```

3. Update the deployment and service configurations as needed in the kustomization.yaml file located in the application's directory.

4. Build and apply the deployment and service manifests using Kustomize:
```bash
kubectl apply -k .
```
This command will apply the deployment and service manifests to the Kubernetes cluster using Kustomize, which will automatically manage the resources defined in the kustomization.yaml file

5. Verify the deployment:
```bash
kubectl get pods
kubectl get services
```
Ensure that the pods are running and the service is successfully created.

6. Depending on your Kubernetes cluster setup, you can access the application using the service's cluster IP or by exposing it externally through an ingress or LoadBalancer.
