output "security_group_ids" {
  value = [for security in aws_security_group.allow_tls : security.id]
}