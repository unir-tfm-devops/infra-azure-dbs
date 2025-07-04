# Test databases
module "spring_boot_template_test" {
  source = "./modules/database"

  database_name = "spring-boot-template-test"
  username      = "spring-boot-template-test-user"
  password      = "secure_password_123"

  depends_on = [time_sleep.wait_for_db]

  providers = {
    postgresql = postgresql.test
  }
}