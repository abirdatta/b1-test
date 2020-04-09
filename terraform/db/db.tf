terraform {
  required_version = ">= 0.12.6"
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = "env:/${terraform.workspace}/b1-test-infra"
    region = var.region
  }
}

module "db_subnet_group" {
  source            = "../modules/DB_SUBNET_GROUP"
  env               = terraform.workspace
  subnet_ids        = data.terraform_remote_state.infra.outputs.private_db_subnet_ids
  subnet_group_name = "${terraform.workspace}-db_subnet_group"
  tag_name          = "${terraform.workspace}-db_subnet_group"
}

module "maria" {
  source                 = "../modules/RDS/"
  allocated_storage      = var.allocated_storage[terraform.workspace]
  engine                 = var.engine
  engine_version         = var.engine_version
  identifier             = "${terraform.workspace}-${var.identifier}"
  backup_window          = var.backup_window
  instance_class         = var.instance_class[terraform.workspace]
  maintenance_window     = var.maintenance_window
  password               = var.password
  port                   = var.db-port
  username               = var.username
  name                   = var.db-name
  db_subnet_group_name   = module.db_subnet_group.db_subnet_group_name
  vpc_security_group_ids = [data.terraform_remote_state.infra.outputs.rds_db_security_group_id]
  multi_az               = var.multi_az[terraform.workspace]
  tags = {
    Name = "${terraform.workspace}-mariadb"
    env  = terraform.workspace
  }
}


