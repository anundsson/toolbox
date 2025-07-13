# Multi-Tenancy Setup Guide

This guide provides examples and configurations for setting up a multi-tenancy Kubernetes cluster.

## Key Concepts

1. **Namespace Isolation**: Each tenant gets its own namespace(s)
2. **Network Policies**: Restrict traffic between tenant namespaces
3. **Resource Quotas**: Limit resource consumption per tenant
4. **RBAC**: Define roles and permissions per tenant
5. **Policy Enforcement**: Use admission controllers (Kyverno or OPA Gatekeeper)

## Example Tenant Setup

The files in this directory provide examples for:
- Creating tenant namespaces with proper labels
- Setting up resource quotas for tenants
- Configuring network policies for isolation
- Setting up RBAC for tenant administrators
- Example constraints and policies

## Resources

- [Multi-tenancy Special Interest Group](https://github.com/kubernetes-sigs/multi-tenancy)
- [Kubernetes Multi-tenancy Best Practices](https://kubernetes.io/blog/2021/04/15/three-tenancy-models-for-kubernetes/)
