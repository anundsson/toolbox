# ArgoCD Quickstart

This folder contains manifests and instructions to install ArgoCD on your Kubernetes cluster.

## Installation

1. Create the `argocd` namespace:
   ```sh
   kubectl create namespace argocd
   ```
2. Apply the official ArgoCD installation manifest:
   ```sh
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```
   Or use the local copy in this folder:
   ```sh
   kubectl apply -n argocd -f install.yaml
   ```

## Accessing ArgoCD

Port-forward the ArgoCD server:
```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Login with:
- Username: `admin`
- Password: Run:
  ```sh
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
  ```

## Resources
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/en/stable/)
