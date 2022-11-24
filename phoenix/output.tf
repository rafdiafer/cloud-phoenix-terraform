output "app_connect_url" {
  description = "URL to access the App"
  value       = "http://${module.containers_cluster.alb_url}"
}