# Production databases
module "spring_boot_template_prod" {
  source = "./modules/database"

  database_name = "spring-boot-template-prod"
  username      = "spring-boot-template-prod-user"
  password      = "secure_password_123"

  depends_on = [time_sleep.wait_for_db]

  providers = {
    postgresql = postgresql.prod
  }
}

module "nodejs_template_prod" {
  source = "./modules/database"

  database_name = "nodejs-template-prod"
  username      = "nodejs-template-prod-user"
  password      = "nodejs-template-prod-password"

  depends_on = [time_sleep.wait_for_db]

  providers = {
    postgresql = postgresql.prod
  }
}
