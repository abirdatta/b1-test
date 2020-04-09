resource "aws_ecs_cluster" "ecs" {
  name = var.name
}

resource "aws_iam_role" "ecs_iam_role" {
  name = "${var.name}_ecs_instance_role"
  path = "/ecs/"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ecs_iam_instance_profile" {
  name = "${var.name}_ecs_instance_profile"
  role = aws_iam_role.ecs_iam_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_role" {
  role = aws_iam_role.ecs_iam_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_cloudwatch_role" {
  role = aws_iam_role.ecs_iam_role.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")
  vars = {
    additional_user_data_script = var.additional_user_data_script
    ecs_cluster                 = aws_ecs_cluster.ecs.name
  }
}

resource "aws_key_pair" "ecs-instance-key-pair" {
  key_name   = "${var.name}-key"
  public_key = var.public_key
}


resource "aws_launch_configuration" "instance" {
  name_prefix          = "${var.name}-lc"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ecs_iam_instance_profile.name
  user_data            = data.template_file.user_data.rendered
  security_groups      = var.security_groups
  key_name             = aws_key_pair.ecs-instance-key-pair.key_name

  root_block_device {
    volume_size = var.instance_root_volume_size
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name = "${var.name}-asg"

  launch_configuration = aws_launch_configuration.instance.name

  vpc_zone_identifier  = var.vpc_subnets
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  desired_capacity     = var.asg_desired_size

  health_check_grace_period = 300
  health_check_type         = "EC2"

  lifecycle {
    create_before_destroy = true
  }
}