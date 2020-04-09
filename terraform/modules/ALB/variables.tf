variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "Indicates whether HTTP/2 is enabled in application load balancers."
  type        = bool
  default     = true
}

variable "enable_cross_zone_load_balancing" {
  description = "Indicates whether cross zone load balancing should be enabled in application load balancers."
  type        = bool
  default     = false
}


variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = number
  default     = 60
}

variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack."
  type        = string
  default     = "ipv4"
}

variable "load_balancer_is_internal" {
  description = "Boolean determining if the load balancer is internal or externally facing."
  type        = bool
  default     = false
}

variable "load_balancer_create_timeout" {
  description = "Timeout value when creating the ALB."
  type        = string
  default     = "10m"
}

variable "load_balancer_delete_timeout" {
  description = "Timeout value when deleting the ALB."
  type        = string
  default     = "10m"
}

variable "load_balancer_name" {
  description = "The resource name and Name tag of the load balancer."
  type        = string
}

variable "load_balancer_update_timeout" {
  description = "Timeout value when updating the ALB."
  type        = string
  default     = "10m"
}

variable "logging_enabled" {
  description = "Controls if the ALB will log requests to S3."
  type        = bool
  default     = true
}

variable "log_bucket_name" {
  description = "S3 bucket (externally created) for storing load balancer access logs. Required if logging_enabled is true."
  type        = string
}

variable "log_location_prefix" {
  description = "S3 prefix within the log_bucket_name under which logs are stored."
  type        = string
  default     = ""
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "subnets" {
  description = "A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "security_groups" {
  description = "The security groups to attach to the load balancer. e.g. [\"sg-edcd9784\",\"sg-edcd9785\"]"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC id where the load balancer and other resources will be deployed."
  type        = string
}

variable "target_group_name" {
  description = "Target Group Name"
}

variable "port" {

}

variable "protocol" {

}

variable "stickiness_enabled" {
  default = true
  type = bool
}

variable "target_type" {
  default = "instance"
}

variable "health_check_interval" {

}

variable "health_check_path" {

}

variable "health_check_port" {

}

variable "health_check_protocol" {

}

variable "health_check_timeout" {

}

variable "health_check_healthy_threshold" {

}

variable "health_check_unhealthy_threshold" {

}

variable "health_check_matcher" {}


