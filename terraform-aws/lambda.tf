module "lambda" {
  source = "github.com/SthoreH/shd-terraform-aws-lambda?ref=v1.0.0"

  # ...

  tags = local.tags
}