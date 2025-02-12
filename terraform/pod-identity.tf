# Enables pods to authorize with AWS services
# Provides ability to manage credentials for applications, similar to EC2 instance profiles providing credentials to EC2 instances
resource "aws_eks_addon" "pod_identity" {
  cluster_name  = aws_eks_cluster.eks.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.4-eksbuild.1"     # Latest as of 2/11/2025
}