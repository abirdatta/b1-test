variable "cluster_id" {}
variable "desired_count" {}
variable "launch_type" {default = "EC2"}
variable "service_name" {}
variable "task_definition" {}
variable "deployment_maximum_percent" {default = 200}
variable "deployment_minimum_healthy_percent" {default = 100}

variable "target_group_arn" {}
variable "container_name" {}
variable "container_port" {}