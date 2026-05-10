locals {
  function_name        = "lbd-products-service"
  function_description = "Products service Lambda"
  handler              = "lambda_function.lambda_handler"
  runtime              = "python3.13"

  function_alias = var.environment

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

  architectures = ["arm64"]

  # Powertools layer ARN is resolved from a public AWS-managed SSM parameter (see data.tf),
  # so the latest version is picked up automatically without bumping a hardcoded layer version.
  powertools_layer_arch = local.architectures[0]

  layers = [
    data.aws_ssm_parameter.powertools_layer_arn.value
  ]

  tags = {
    ManagedBy  = "terraform"
    Repository = "github.com/${var.organization}/${var.github_repository}"
  }
}
