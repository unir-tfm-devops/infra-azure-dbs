output "database_name" {
  description = "Name of the created database"
  value       = postgresql_database.database.name
}

output "username" {
  description = "Name of the created user/role"
  value       = postgresql_role.user.name
}

output "database" {
  description = "The created database resource"
  value       = postgresql_database.database
}

output "user" {
  description = "The created user/role resource"
  value       = postgresql_role.user
} 