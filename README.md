# Amazon Elastic Kubernetes Service (EKS) Lab

## Specs and Info

### EKS Cluster

- Running Kubernetes version 1.32 (current for EKS as of 2/8/2025)
- Two private and public subnets within two availability zones using NAT Gateway

After provisioned, update kubeconfig to interact with cluster via `kubectl`:

```bash
aws eks update-kubeconfig --region us-east-1 --name staging-kube
```

### To-Do

- Implement a NAT Instance rather than a NAT Gateway
