output "cluster_id" {
  value = aws_ecs_cluster.ecs.id
}

output "instance_role" {
  value = aws_iam_role.ecs_iam_role.name
}

output "instance_az" {
  value = aws_autoscaling_group.asg.availability_zones
}