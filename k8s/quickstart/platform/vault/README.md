# HashiCorp Vault Quickstart

This folder contains instructions for installing HashiCorp Vault, a secrets management solution for Kubernetes.

## Installation (Helm)

1. Add the Helm repo:

   ```sh
   helm repo add hashicorp https://helm.releases.hashicorp.com
   helm repo update
   ```

2. Install Vault:

   ```sh
   helm install vault hashicorp/vault \
     --namespace vault \
     --create-namespace \
     --values values.yaml
   ```

3. Initialize Vault:

   ```sh
   kubectl exec -it vault-0 -n vault -- vault operator init
   ```

4. Unseal Vault (repeat for each unseal key):

   ```sh
   kubectl exec -it vault-0 -n vault -- vault operator unseal <unseal-key>
   ```

## Integration with External Secrets

Create a SecretStore that uses Vault backend:

```yaml
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: vault-backend
  namespace: tenant-a
spec:
  provider:
    vault:
      server: "http://vault.vault.svc:8200"
      path: "secret"
      version: "v2"
      auth:
        kubernetes:
          mountPath: "kubernetes"
          role: "tenant-a"
```

## Resources

- [Vault Documentation](https://www.vaultproject.io/docs)
- [Vault Kubernetes Integration](https://www.vaultproject.io/docs/platform/k8s)
