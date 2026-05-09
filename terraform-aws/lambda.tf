module "lambda" {
  source = "github.com/SthoreH/shd-terraform-aws-lambda?ref=v1.0.0"

  name          = "${local.app_name}-lbd"
  description   = "Products service Lambda"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.13"
  role          = module.lambda_role.role_arn
  zip_file_path = var.lambda_zip_path

  log_retention_days = 14

  tags = local.tags
}
