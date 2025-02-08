# Most common parameters to be used with Terraform as local variables
locals {
  env           = "staging"
  region        = "us-east-1"
  zone1         = "us-east-1a"      # EKS requires at least 2 subnets in 2 different AZs
  zone2         = "us-east-1b"
  eks_name      = "kube"
  eks_version   = "1.32"
}