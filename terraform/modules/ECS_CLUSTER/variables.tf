variable "additional_user_data_script" {
  description = "Additional user data script (default=\"\")"
  default     = ""
}

variable "asg_max_size" {
  description = "Maximum number EC2 instances"
}

variable "asg_min_size" {
  description = "Minimum number of instances"
}

variable "asg_desired_size" {
  description = "Desired number of instances"
}

variable "instance_log_group" {
  description = "Instance log group in CloudWatch Logs"
  default     = ""
}

variable "instance_root_volume_size" {
  description = "Root volume size (default=50)"
  default     = 50
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "name" {
  description = "Base name to use for resources in the module"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "vpc_id" {
  description = "VPC ID to create cluster in"
}

variable "vpc_subnets" {
  description = "List of VPC subnets to put instances in"
  type = list(string)
}

variable "ami_id" {}
variable "security_groups" {
  type = list(string)
}
variable "public_key" {}