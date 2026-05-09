locals {
  app_name = "products-service"

  # Convention: the CI/CD pipeline packages the Lambda to <repo-root>/dist/lambda.zip
  # before terraform plan/apply. Keeping the path here avoids passing -var from workflows.
  lambda_zip_path = "${path.root}/../dist/lambda.zip"

  environment_variables = {
    ENVIRONMENT = var.environment
  }

  template_variables = {
    account_id        = data.aws_caller_identity.current.account_id
    orders_table_name = "orders"
  }

  tags = {
    ManagedBy  = "terraform"
    Repository = "github.com/${var.organization}/${var.github_repository}"
  }
}
