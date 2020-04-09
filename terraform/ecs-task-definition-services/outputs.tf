output "alb_dns_to_access_api" {
  value = data.terraform_remote_state.infra.outputs.alb_dns
}