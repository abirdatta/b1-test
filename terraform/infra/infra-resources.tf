terraform {
  required_version = ">= 0.12.6"
}

data "aws_ami" "ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

module "ecs_cluster" {
  source                    = "../modules/ECS_CLUSTER/"
  ami_id                    = data.aws_ami.ecs.id
  name                      = "${terraform.workspace}-${var.name}"
  asg_desired_size          = var.asg_desired_size[terraform.workspace]
  asg_max_size              = var.asg_max_size[terraform.workspace]
  asg_min_size              = var.asg_min_size[terraform.workspace]
  instance_type             = var.instance_type[terraform.workspace]
  public_key                = var.public_key
  security_groups           = [module.ec2_security_group.security_group_id]
  vpc_id                    = module.b1-test_vpc.vpc_id
  vpc_subnets               = module.compute_private_subnets.subnet_ids
  instance_root_volume_size = var.instance_root_volume_size
  tags = {
    Name = "${terraform.workspace}-${var.name}"
    env  = terraform.workspace
  }
  additional_user_data_script = var.additional_user_data_script
}

module "alb_and_target_group" {
  source                           = "../modules/ALB/"
  env                              = terraform.workspace
  load_balancer_name               = "${terraform.workspace}-${var.load_balancer_name}"
  log_bucket_name                  = "${terraform.workspace}-${var.load_balancer_name}"
  port                             = var.port
  protocol                         = var.protocol
  security_groups                  = [module.alb_security_group.security_group_id]
  vpc_id                           = module.b1-test_vpc.vpc_id
  subnets                          = module.compute_public_subnets.subnet_ids
  target_group_name                = "${terraform.workspace}-${var.target_group_name}"
  health_check_healthy_threshold   = var.health_check_healthy_threshold
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
  health_check_interval            = var.health_check_interval
  health_check_path                = var.health_check_path
  health_check_port                = var.health_check_port
  health_check_protocol            = var.health_check_protocol
  health_check_timeout             = var.health_check_timeout
  health_check_matcher             = var.health_check_matcher
  logging_enabled                  = var.logging_enabled
  tags = {
    Name = "${terraform.workspace}-${var.load_balancer_name}"
    env  = terraform.workspace
  }
}
