variable "cidr_block" {
  description = "CIDR blcok for the VPC"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default = "default"
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type = bool
  default = true
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type = bool
  default = true
}

variable "tags" {
  type = map(string)
  description = "tags to be added to the vpc"
}