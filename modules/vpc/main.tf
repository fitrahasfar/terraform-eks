# Import the official VPC module from the Terraform Registry
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"  # Source module vpc
  version = "~> 5.1.2"

  name = var.name   # Name VPC
  cidr = var.cidr   # Main cird VPC

  azs = var.azs                         # Availability zone list
  public_subnets = var.public_subnet   # Public subnets
  private_subnets = var.private_subnet # Private subnets

  enable_nat_gateway = true             # NAT to access internet
  single_nat_gateway = false            # 1 NAT to all AZ
  enable_dns_hostnames = true           # Active DNS hostname
  enable_dns_support = true             # Active DNS support 

#   enable_flow_log = true                      # Enable VPC traffic logging
#   create_flow_log_cloudwatch_log_group = true # Create a log group in CloudWatch
#   create_flow_log_cloudwatch_iam_role = true  # Create an IAM role to send logs

  # Tag public subnet for ILB (Internal Load Balancer)
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/elb"            = 1
  }

  # Tag private subnet for ILB
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/internal-elb"   = 1
  }

  # Additional tags
  tags = {
    Environment = var.environment
    Terraform = "true"
  }
}