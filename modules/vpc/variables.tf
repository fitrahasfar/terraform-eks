variable "name" {
  description = "Name VPC"
  type = string
}

variable "cidr" {
  description = "CIDR block for VPC"
  type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnet" {
  type = list(string)
}

variable "private_subnet" {
  type = list(string)
}

variable "environment" {
  type = string
}