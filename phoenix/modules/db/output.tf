output "mongo_instance_private_ip" {
  value = aws_instance.mongo_ecs_instance.private_ip
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.mongo_ecs.arn
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.mongo_ecs.name
}

output "ssm_mongo_connection_url" {
  value = aws_ssm_parameter.ssm_mongo_connection_url.value
}