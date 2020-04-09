variable "log_group_name" {
  default = "b1-test-demo"
}

variable "log_stream_name" {
  default = "task-logs"
}

variable "remote_state_bucket" {
  default = "b1-test.terraform.tfstate"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "host_port" {
  default = 0
}

variable "container_port" {
  default = 8080
}

variable "memory_reservation" {
  default = 500
}

variable "b1-test_image_version" {
  default = "SED_IMAGE_VERSION"
}

variable "td_name" {
  default = "b1-test-task-def"
}

variable "service_name" {
  default = "b1-test-service"
}

variable "container_name" {
  default = "b1-test_container"
}