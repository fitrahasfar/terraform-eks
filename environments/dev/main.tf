# Region provider
provider "aws" {
  region = var.region
}

# VPC
module "vpc" {
  source = "../../modules/vpc"  # Path to the reuseable VPC module

  name = "dev-vpc"
  cidr = "10.50.0.0/16"
  environment = "dev"

  # Availbility zone
  azs = [ 
    "ap-southeast-1a",
    "ap-southeast-1b",
    "ap-southeast-1c"
   ]

   # Public Subnet
   public_subnet = [
    "10.50.1.0/24",
    "10.50.2.0/24",
    "10.50.3.0/24"
   ]

   # Private subnet
   private_subnet = [
    "10.50.4.0/24",
    "10.50.5.0/24",
    "10.50.6.0/24"
   ]
}

# EKS
module "eks" {
  source = "../../modules/eks"                # Path to the reuseable VPC module

  cluster_name = "dev-eks-cluster"            # Name of the EKS cluster
  environment = "dev"                         # Deployment env
  vpc_id = module.vpc.vpc_id                  # VPC ID where EKS cluster will be deployed
  private_subnet = module.vpc.private_subnet  # Private subnet userd for worker nodes
}