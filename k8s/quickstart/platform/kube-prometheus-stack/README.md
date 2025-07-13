# Monitoring Stack Quickstart

This folder contains instructions for installing the Prometheus & Grafana monitoring stack via kube-prometheus-stack.

## Installation (Helm)

1. Add the Helm repo:

   ```sh
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   ```

2. Install kube-prometheus-stack:

   ```sh
   helm install monitoring prometheus-community/kube-prometheus-stack \
     --namespace monitoring \
     --create-namespace \
     --values values.yaml
   ```

3. Access Grafana:

   ```sh
   kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80
   ```

   Default login:
   - Username: admin
   - Password: prom-operator (configurable in values.yaml)

## Resources

- [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
- [Prometheus Operator](https://prometheus-operator.dev/)
