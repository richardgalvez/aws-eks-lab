resource "aws_eks_node_group" "global" {
  cluster_name    = aws_eks_cluster.eks.name
  version         = local.eks_version
  node_group_name = "global"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    aws_subnet.private_zone1.id,
    aws_subnet.private_zone2.id
  ]

  capacity_type   = "SPOT"
  instance_types  = ["t3.small"]

  scaling_config {
    desired_size  = 1
    max_size      = 2
    min_size      = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "global"
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}

resource "aws_iam_role" "nodes" {
  name = "${local.env}-${local.eks_name}-eks-nodes"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# This policy now includes AssumeRoleForPodIdentity for the Pod Identity Agent
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role        = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role        = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role        = aws_iam_role.nodes.name
}