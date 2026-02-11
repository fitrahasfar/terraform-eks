# Region provider
provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"

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