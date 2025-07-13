# Essential Kubernetes Tools

This folder is for additional essential tools for your cluster, such as metrics-server, ingress-nginx, etc.

## Example: metrics-server

1. Create the namespace (if needed):
   ```sh
   kubectl create namespace kube-system
   ```
2. Apply the metrics-server manifest:
   ```sh
   kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
   ```

## Example: ingress-nginx

1. Create the namespace:
   ```sh
   kubectl create namespace ingress-nginx
   ```
2. Apply the ingress-nginx manifest:
   ```sh
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.1/deploy/static/provider/kind/deploy.yaml
   ```

Add more tools as needed, following this structure.
