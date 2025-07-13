# KEDA Quickstart

This folder contains instructions for installing KEDA (Kubernetes Event-driven Autoscaling), which allows for fine-grained autoscaling based on event metrics.

## Installation (Helm)

1. Add the Helm repo:

   ```sh
   helm repo add kedacore https://kedacore.github.io/charts
   helm repo update
   ```

2. Install KEDA:

   ```sh
   helm install keda kedacore/keda \
     --namespace keda \
     --create-namespace \
     --values values.yaml
   ```

## Resources

- [KEDA Documentation](https://keda.sh/docs/)
- [Scalers](https://keda.sh/docs/latest/scalers/)
