variable "vpc_name" {
  description = "the name of the VPC"
  default     = "b1-test_VPC"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = map(string)
  default = {
    dev     = "10.2.0.0/16"
    qa      = "10.3.0.0/16"
    prod    = "10.4.0.0/16"
    default = "10.1.0.0/16"
  }
}

variable "region" {
  default = "ap-southeast-1"
}

variable "zones_cidr_map_compute_private" {
  description = "Zones and CIDR map"
  type        = map(map(string))
  default = {
    dev = {
      "a" = "10.2.1.0/24"
      "b" = "10.2.2.0/24"
      "c" = "10.2.3.0/24"
    },
    qa = {
      "a" = "10.3.1.0/24"
      "b" = "10.3.2.0/24"
      "c" = "10.3.3.0/24"
    },
    prod = {
      "a" = "10.4.1.0/24"
      "b" = "10.4.2.0/24"
      "c" = "10.4.3.0/24"
    },
    default = {
      "a" = "10.1.1.0/24"
      "b" = "10.1.2.0/24"
      "c" = "10.1.3.0/24"
    }
  }
}

variable "subnet_name_prefix_compute_private" {
  description = "subnet name prefix like compute-private, db-private etc."
  default     = "b1-test_compute-private"
}

variable "subnet_name_prefix_db_private" {
  description = "subnet name prefix like compute-private, db-private etc."
  default     = "b1-test_db-private"
}

variable "zones_cidr_map_db_private" {
  description = "Zones and CIDR map"
  type        = map(map(string))
  default = {
    dev = {
      "a" = "10.2.4.0/24"
      "b" = "10.2.5.0/24"
      "c" = "10.2.6.0/24"
    },
    qa = {
      "a" = "10.3.4.0/24"
      "b" = "10.3.5.0/24"
      "c" = "10.3.6.0/24"
    },
    prod = {
      "a" = "10.4.4.0/24"
      "b" = "10.4.5.0/24"
      "c" = "10.4.6.0/24"
    },
    default = {
      "a" = "10.1.4.0/24"
      "b" = "10.1.5.0/24"
      "c" = "10.1.6.0/24"
    }
  }
}

variable "zones_cidr_map_compute_public" {
  description = "Zones and CIDR map"
  type        = map(map(string))
  default = {
    dev = {
      "a" = "10.2.7.0/24"
      "b" = "10.2.8.0/24"
      "c" = "10.2.9.0/24"
    },
    qa = {
      "a" = "10.3.7.0/24"
      "b" = "10.3.8.0/24"
      "c" = "10.3.9.0/24"
    },
    prod = {
      "a" = "10.4.7.0/24"
      "b" = "10.4.8.0/24"
      "c" = "10.4.9.0/24"
    },
    default = {
      "a" = "10.1.7.0/24"
      "b" = "10.1.8.0/24"
      "c" = "10.1.9.0/24"
    }
  }
}

variable "subnet_name_prefix_compute_public" {
  description = "subnet name prefix like compute-private, db-private etc."
  default     = "b1-test_compute-public"
}

variable "internet_gateway_cidr" {
  default = "0.0.0.0/0"
}

variable "public_subnet_route_table_name" {
  default = "b1-test_public_route_table"
}

variable "private_subnet_route_table_name" {
  default = "b1-test_private_route_table"
}

variable "db_subnet_route_table_name" {
  default = "b1-test_db_private_route_table"
}

variable "rds_db_sg_name" {
  default = "b1-test_rds_db_sg"
}

variable "alb_sg_name" {
  default = "b1-test_alb_sg"
}

variable "ec2_sg_name" {
  default = "b1-test_ec2_sg"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = map(string)
  default = {
    dev     = "t2.small"
    qa      = "t2.medium"
    prod    = "m5.large"
    default = "t2.micro"
  }
}

variable "name" {
  description = "Base name to use for resources in the module"
  default     = "b1-test"
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/2ZxOXkJoK4Y3lf0IlvZGTLqXxgfte9SKxlFlXsJVK1p4q1jpEvXpMUCQ3UZih238ULCyfxZSFIKk0I30HjcDFBnKk+cqj9ZRHOJ/G0nC5xdZEP7t4DyHmGa+FpEHQIALCh1aIEUfVRarOIXmACJoJXUkoEhR1Ic0klDrzZoMSZSrZ8277kALD+PNAZdI5xFXdvn2F74sdyqHFuA/VP9tY+cZKYh6ZoUk8n3Hn635EtX1xtVc3j+Cp1qIac9z87mKHNZ88OJCKgjMJmBJk7KBJpFZJ/oH3v9eOweZsN9OcZFh7VORNRgHZkT/Xw8j1COy1JxFQWvW5+ophaEStuX1 abirdatta.in@gmail.com"
}

variable "asg_desired_size" {
  type = map(string)
  default = {
    dev     = 2
    qa      = 1
    prod    = 2
    default = 1
  }
}

variable "asg_max_size" {
  type = map(string)
  default = {
    dev     = 2
    qa      = 2
    prod    = 4
    default = 1
  }
}

variable "asg_min_size" {
  type = map(string)
  default = {
    dev     = 1
    qa      = 1
    prod    = 1
    default = 1
  }
}

variable "instance_root_volume_size" {
  default = 60
}

variable "additional_user_data_script" {
  default = "sudo yum install -y mysql"
}

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
  default     = true
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
  default     = "b1-test-alb"
}

variable "load_balancer_update_timeout" {
  description = "Timeout value when updating the ALB."
  type        = string
  default     = "10m"
}

variable "logging_enabled" {
  description = "Controls if the ALB will log requests to S3."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "target_group_name" {
  description = "Target Group Name"
  default     = "b1-test-tg"
}

variable "port" {
  default = 80
}

variable "protocol" {
  default = "HTTP"
}

variable "stickiness_enabled" {
  default = true
  type    = bool
}

variable "target_type" {
  default = "instance"
}

variable "health_check_interval" {
  default = 20
}

variable "health_check_path" {
  default = "/"
}

variable "health_check_port" {
  default = "traffic-port"
}

variable "health_check_protocol" {
  default = "HTTP"
}

variable "health_check_timeout" {
  default = 5
}

variable "health_check_healthy_threshold" {
  default = 3
}

variable "health_check_unhealthy_threshold" {
  default = 3
}

variable "health_check_matcher" {
  default = "200"
}

# RDS variables
variable "identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  default     = "mariadb"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = map(string)
  default = {
    dev     = 20
    qa      = 30
    prod    = 30
    default = 20
  }
}

variable "prod_allocated_storage" {
  description = "The allocated storage in gigabytes"
  default     = 40
}


variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  type        = string
  default     = ""
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
  type        = string
  default     = ""
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  type        = string
  default     = ""
}

variable "license_model" {
  description = "License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"
  type        = string
  default     = ""
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  type        = bool
  default     = false
}

variable "engine" {
  description = "The database engine to use"
  default     = "MariaDB"
}

variable "engine_version" {
  description = "The engine version to use"
  default     = "10.3.8"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = map(string)
  default = {
    dev     = "db.t2.medium"
    qa      = "db.t2.medium"
    prod    = "db.m5.large"
    default = "db.t2.medium"
  }
}

variable "db-name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "mydb"
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "myuser"
}

variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  default     = "password"
}

variable "db-port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = 3306
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted."
  type        = string
  default     = null
}

variable "remote_state_bucket" {
  default = "b1-test.terraform.tfstate"
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = ""
}

variable "availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = ""
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = map(string)
  default = {
    dev     = false
    qa      = true
    prod    = true
    dafault = false
  }
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  type        = number
  default     = 0
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  type        = string
  default     = ""
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
  type        = string
  default     = "rds-monitoring-role"
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  type        = bool
  default     = false
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified)"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 1
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "03:46-04:16"
}

variable "option_group_name" {
  description = "Name of the DB option group to associate."
  type        = string
  default     = ""
}

variable "timezone" {
  description = "(Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information."
  type        = string
  default     = ""
}

variable "character_set_name" {
  description = "(Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information"
  type        = string
  default     = ""
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  type        = list(string)
  default     = []
}

variable "timeouts" {
  description = "(Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times"
  type        = map(string)
  default = {
    create = "40m"
    update = "80m"
    delete = "40m"
  }
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = false
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data."
  type        = number
  default     = 7
}

variable "max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}