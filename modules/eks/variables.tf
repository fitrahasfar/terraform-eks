variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet" {
  type = list(string)
}

# variable "public_subnet" {
#   type = list(string)
# }

variable "environment" {
  type = string
}