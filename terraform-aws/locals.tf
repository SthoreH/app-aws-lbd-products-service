locals {
  app_name = "products-service"

  template_variables = {
    account_id        = data.aws_caller_identity.current.account_id
    orders_table_name = "orders"
  }

  tags = {
    ManagedBy  = "terraform"
    Repository = "github.com/${var.organization}/${var.github_repository}"
  }
}
