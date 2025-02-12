# Amazon Elastic Kubernetes Service (EKS) Lab

## Specs and Info

### EKS Cluster

- Running Kubernetes version 1.32 (current for EKS as of 2/8/2025)
- Two private and public subnets within two availability zones using NAT Gateway

### To-Do

- Implement a NAT Instance rather than a NAT Gateway

## Notes

After EKS cluster and nodes are provisioned, clear your current `~/.kube/config` file (if needed) then use `aws eks update-kubeconfig` to interact with cluster via `kubectl`:

```bash
aws eks update-kubeconfig --region us-east-1 --name staging-kube
```

To check the maximum amount of pods running for a given instance with optional capabilties:

```bash
./max-pods-calculator.sh --instance-type t3.small --cni-version 1.19.2-eksbuild.1
```

Given t3.small, for example, the max number of pods to run in a single instance is 11.

Get the latest versions of EKS Add-ons by using:

```bash
aws eks describe-addon-versions --region us-east-1 --addon-name eks-pod-identity-agent
```
