# description is optional
variable "region" {
  description = "VPC Region"
  type = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type = list(string)
}
