resource "aws_eks_node_group" "nodes_general" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "nodes-general"

  node_role_arn = aws_iam_role.node_role.arn
  # will use only the public subnets for the workers
  subnet_ids = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  scaling_config {
    # Desired number of worker nodes
    desired_size = 1
    # Maximum number of worker nodes
    max_size = 2
    # Minimum number of worker nodes
    min_size = 1
  }

  capacity_type  = "SPOT"
  instance_types = ["t2.micro"]
  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version = false

  labels = {
    "role" = "nodes-general"
  }

  # Kubernetes version
  version = "1.21"

  #   update_config {
  #     max_unavailable = 2
  #   }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}


# The policy that grants an entity permission to assume the role
resource "aws_iam_role" "node_role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })

}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_role.name
} 