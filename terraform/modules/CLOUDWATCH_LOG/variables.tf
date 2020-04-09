variable "log_group_name" {}
variable "retention_in_days" {
  default = "30"
}
variable "kms_key_id" {
  default = ""
}
variable "tags" {
  type = map(string)
}
variable "log_stream_name" {}