module "eks" {
  source = "terraform-aws-modules/eks/aws"      # Source module EKS
  version = "~> 20.0"                           # Version module EKS

  cluster_name = var.cluster_name               # Name cluster EKS
  cluster_version = "1.35"                      # Version Kubernetes
  cluster_endpoint_public_access = true         # Endpoint cluster can access public
  vpc_id = var.vpc_id                           # ID VPC after create
  subnet_ids = var.private_subnet               # Subnet for worker node
  control_plane_subnet_ids = var.private_subnet # Subnet for control plant

  # Addons Kubernetes
  cluster_addons = {                            # This add-on is an important component for the Kubernetes cluster to run normally.
    coredns = {                                 # Kubernetes internal DNS (so that pods and services can find each other)
        most_recent = true                      # use new version
    }
    kube-proxy = {                              # Handles networking rules and service routing
        most_recent = true
    }
    vpc-cni = {                                 # Assigns VPC IP addresses to pods (AWS networking plugin)
        most_recent = true
    }
  }

  # Managed node group
  eks_managed_node_group_defaults = {           # Default configuration all node groups
    instance_type   = ["t3.large"]
    capacity_type   = "SPOT"                    # SPOT is cheaper but can be interrupted by AWS
    ami_type        = "AL2023_x86_64_STANDARD"
  }

  eks_managed_node_groups = {                   # Definition of node groups to be created
    main = {
        min_size        = 1                     # Minimal node
        max_size        = 3                     # Maximal node
        desired_size    = 1                     # Default node

        capacity_type   = "SPOT"

        tags = {
            Environment = var.environment
        }
    }
  }

  # Additional Tags
  tags = {
    Environment = var.environment
    terraform   = "true"
  }
}
