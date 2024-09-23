output "endpoint" {
  description = "The RDS instance endpoint"
  value       = aws_db_instance.default.endpoint  # Ensure that aws_db_instance resource is used in your RDS module
}
