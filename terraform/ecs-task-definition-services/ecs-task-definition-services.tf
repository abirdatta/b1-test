terraform {
  required_version = ">= 0.12.6"
}

module "b1-test_cw_logs" {
  source          = "../modules/CLOUDWATCH_LOG"
  log_group_name  = "${terraform.workspace}-${var.log_group_name}"
  log_stream_name = var.log_stream_name
  tags = {
    Name = "${terraform.workspace}-${var.log_group_name}"
    env  = terraform.workspace
  }
}

data "aws_caller_identity" "current" {}

module "taskdef_b1-test" {
  source                = "../modules/TASK-DEFINITION"
  container_definitions = data.template_file.b1-test_container_def.rendered
  task_definition_name  = "${terraform.workspace}-${var.td_name}"
  network_mode          = "bridge"
}

data "template_file" "b1-test_container_def" {
  template = file("b1-test-container-definition.json")
  vars = {
    log_group_name     = module.b1-test_cw_logs.cw_log_group_name
    log_stream_name    = module.b1-test_cw_logs.cw_log_stream_name
    account_id         = data.aws_caller_identity.current.account_id
    region             = var.region
    host_port          = var.host_port
    container_port     = var.container_port
    memory_reservation = var.memory_reservation
    image_version      = var.b1-test_image_version
    db_pass            = data.terraform_remote_state.db.outputs.db_instance_password
    db_user            = data.terraform_remote_state.db.outputs.db_instance_username
    db_name            = data.terraform_remote_state.db.outputs.db_instance_name
    db_port            = data.terraform_remote_state.db.outputs.db_instance_port
    db_host            = data.terraform_remote_state.db.outputs.db_instance_address
    container_name     = var.container_name
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = "env:/${terraform.workspace}/b1-test-infra"
    region = var.region
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = "env:/${terraform.workspace}/b1-test-db"
    region = var.region
  }
}

module "b1-test_service" {
  source           = "../modules/SERVICES"
  cluster_id       = data.terraform_remote_state.infra.outputs.ecs_cluster_id
  task_definition  = module.taskdef_b1-test.task_arn
  service_name     = "${terraform.workspace}-${var.service_name}"
  desired_count    = 2
  target_group_arn = data.terraform_remote_state.infra.outputs.target_group_arn
  container_name   = var.container_name
  container_port   = var.container_port
}