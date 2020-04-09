terraform {
  required_version = ">= 0.12.6"
}

module "b1-test_vpc" {
  source     = "../modules/VPC/"
  cidr_block = var.vpc_cidr[terraform.workspace]
  tags = {
    Name = "${terraform.workspace}-${var.vpc_name}"
    env  = terraform.workspace
  }
}

module "compute_private_subnets" {
  source             = "../modules/SUBNETS/"
  vpc_id             = module.b1-test_vpc.vpc_id
  region             = var.region
  subnet_name_prefix = var.subnet_name_prefix_compute_private
  zones_cidr_map     = var.zones_cidr_map_compute_private[terraform.workspace]
  env                = terraform.workspace
}

module "db_private_subnets" {
  source             = "../modules/SUBNETS/"
  vpc_id             = module.b1-test_vpc.vpc_id
  region             = var.region
  subnet_name_prefix = var.subnet_name_prefix_db_private
  zones_cidr_map     = var.zones_cidr_map_db_private[terraform.workspace]
  env                = terraform.workspace
}

module "compute_public_subnets" {
  source                  = "../modules/SUBNETS/"
  vpc_id                  = module.b1-test_vpc.vpc_id
  region                  = var.region
  subnet_name_prefix      = var.subnet_name_prefix_compute_public
  zones_cidr_map          = var.zones_cidr_map_compute_public[terraform.workspace]
  env                     = terraform.workspace
  map_public_ip_on_launch = true
}

module "nat_gateway" {
  source    = "../modules/NAT_GATEWAY/"
  subnet_id = element(module.compute_public_subnets.subnet_ids, 0)
  env       = terraform.workspace
  name      = "${terraform.workspace}-nat-gateway"
}

module "private_subnet_route_table" {
  source = "../modules/ROUTE_TABLE/"
  cidr_gateway_id_map = {
    "0.0.0.0/0" = module.nat_gateway.nat_gateway_id
  }
  env              = terraform.workspace
  route_table_name = var.private_subnet_route_table_name
  vpc_id           = module.b1-test_vpc.vpc_id
}

module "compute_private_subnet_ngw_association" {
  source         = "../modules/ROUTE_TABLE_ASSOCIATION"
  route_table_id = module.private_subnet_route_table.route_table_id
  subnet_id_map  = module.compute_private_subnets.az_subnet_id_map
}

module "db_subnet_route_table" {
  source = "../modules/ROUTE_TABLE/"
  cidr_gateway_id_map = {
    "0.0.0.0/0" = module.nat_gateway.nat_gateway_id
  }
  env              = terraform.workspace
  route_table_name = var.db_subnet_route_table_name
  vpc_id           = module.b1-test_vpc.vpc_id
}

module "db_private_subnet_ngw_association" {
  source         = "../modules/ROUTE_TABLE_ASSOCIATION"
  route_table_id = module.db_subnet_route_table.route_table_id
  subnet_id_map  = module.db_private_subnets.az_subnet_id_map
}

module "internet_gateway" {
  source = "../modules/INTERNET_GATEWAY/"
  env    = terraform.workspace
  vpc_id = module.b1-test_vpc.vpc_id
}

module "public_subnet_route_table" {
  source = "../modules/ROUTE_TABLE/"
  cidr_gateway_id_map = {
    "0.0.0.0/0" = module.internet_gateway.internet_gateway_id
  }
  env              = terraform.workspace
  route_table_name = var.public_subnet_route_table_name
  vpc_id           = module.b1-test_vpc.vpc_id
}

module "compute_public_subnet_igw_association" {
  source         = "../modules/ROUTE_TABLE_ASSOCIATION"
  route_table_id = module.public_subnet_route_table.route_table_id
  subnet_id_map  = module.compute_public_subnets.az_subnet_id_map
}

module "rds_db_security_group" {
  source  = "../modules/SECURITY_GROUP/"
  env     = terraform.workspace
  sg_name = "${terraform.workspace}-${var.rds_db_sg_name}"
  vpc_id  = module.b1-test_vpc.vpc_id
  sg_desc = "Security Group for RDS instances"
  ingress_rules_list = [
    {
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      cidr_blocks     = module.compute_private_subnets.subnet_cidrs
      security_groups = []
    }
  ]
  egress_rules_list = []
}

module "alb_security_group" {
  source  = "../modules/SECURITY_GROUP/"
  env     = terraform.workspace
  sg_name = "${terraform.workspace}-${var.alb_sg_name}"
  vpc_id  = module.b1-test_vpc.vpc_id
  sg_desc = "Security Group for Application Load Balancer"
  ingress_rules_list = [
    {
      from_port       = 8080
      to_port         = 8080
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  ]
  egress_rules_list = [
    {
      from_port       = 32768
      to_port         = 61000
      protocol        = "tcp"
      cidr_blocks     = module.compute_private_subnets.subnet_cidrs
      security_groups = []
    }
  ]
}

module "ec2_security_group" {
  source  = "../modules/SECURITY_GROUP/"
  env     = terraform.workspace
  sg_name = "${terraform.workspace}-${var.ec2_sg_name}"
  vpc_id  = module.b1-test_vpc.vpc_id
  sg_desc = "Security Group for EC2s in ECS cluster"
  ingress_rules_list = [
    {
      from_port       = 32768
      to_port         = 61000
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = [module.alb_security_group.security_group_id]
    }
  ]
  egress_rules_list = [
    {
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = [module.rds_db_security_group.security_group_id]
    },
    {
      from_port       = 0
      to_port         = 65535
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  ]
}