# ArgoCD Applications Quickstart

This folder contains example ArgoCD Application manifests to install other tooling (e.g., External Secrets, Kyverno, metrics-server) via GitOps.

## Example: External Secrets Operator

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: external-secrets
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://charts.external-secrets.io
    chart: external-secrets
    targetRevision: 0.9.13
    helm:
      releaseName: external-secrets
  destination:
    server: https://kubernetes.default.svc
    namespace: external-secrets
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

## Add more applications for other tools as needed.
