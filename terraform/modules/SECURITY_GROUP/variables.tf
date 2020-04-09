variable "sg_name" {
  description = "Security Group Name"
}

variable "sg_desc" {
  description = "Security Group Description"
}

variable "vpc_id" {
  description = "VPC Id for the subnets"
}

variable "env" {
  description = "Environment dev staging or prod"
}

variable "ingress_rules_list" {
  description = "Ingress Rules for the security group"
  type = list(object({from_port=number,to_port=number,protocol=string,cidr_blocks=list(string),security_groups=list(string)}))
  default = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      security_groups = []
    }
  ]
}

variable "egress_rules_list" {
  description = "Egress Rules for the security group"
  type = list(object({from_port=number,to_port=number,protocol=string,cidr_blocks=list(string),security_groups=list(string)}))
  default = [
    {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      security_groups = []
    }
  ]
}