data "aws_iam_role" "ecs_service_role" {
  name = "AWSServiceRoleForECS"
}

resource "aws_ecs_service" "ecs_service" {
  cluster = var.cluster_id
  desired_count = var.desired_count
  launch_type = var.launch_type
  name = var.service_name
  task_definition = var.task_definition
  deployment_maximum_percent = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  iam_role = data.aws_iam_role.ecs_service_role.arn
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = var.container_name
    container_port = var.container_port
  }

  lifecycle {
    ignore_changes = [desired_count, deployment_maximum_percent, deployment_minimum_healthy_percent]
  }
}

