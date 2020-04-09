resource "aws_ecs_task_definition" "task_definition" {
  container_definitions    = var.container_definitions
  family                   = var.task_definition_name
  network_mode             = var.network_mode
  memory                   = var.memory
  cpu                      = var.cpu
}

