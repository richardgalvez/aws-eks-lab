# Amazon Elastic Kubernetes Service (EKS) Lab

## Specs and Info

### EKS Cluster

- Running Kubernetes version 1.32 (current for EKS as of 2/8/2025)
- Two private and public subnets within two availability zones using NAT Gateway

### To-Do

- Implement a NAT Instance rather than a NAT Gateway
- Automate creation and usage of ACM (Certificate Manager) certs for apps where required

## Getting Started

After EKS cluster and nodes are provisioned via `terraform apply`, clear your current `~/.kube/config` file (if needed) then use `aws eks update-kubeconfig` to interact with cluster via `kubectl`:

```bash
aws eks update-kubeconfig --region us-east-1 --name staging-kube
```

## Notes

To check the maximum amount of pods running for a given instance with optional capabilties:

```bash
./max-pods-calculator.sh --instance-type t3.medium --cni-version 1.19.2-eksbuild.1
```

In this case, with t3.medium, which is used in this lab, the max number of pods to run in a single instance is 17.

* * *

Get the latest versions of EKS Add-ons by using:

```bash
aws eks describe-addon-versions --region us-east-1 --addon-name eks-pod-identity-agent
```

* * *

For YAML files with environment variables, `export` the variables in the terminal first then use `envsubst` to generate a new file that will contain the values. Add '-env' before .yaml to prevent it from being tracked/committed if sensitive information is involved.

```bash
export VALUE="value"

envsubst < {FULL_FILEPATH}/file.yaml > file-env.yaml
```

From there, the file can be applied via `kubectl apply -f file-env.yaml`.

If applying multiple definition files within a folder, temporarily move away or rename/change the filetype the original file before applying. Once done, target the folder with `kubectl apply -f`. For this lab, files renamed to .yaml.txt were the original file with the variable names. If needed, just remove the .txt extension and use the file from there.
