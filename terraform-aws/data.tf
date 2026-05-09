data "aws_caller_identity" "current" {}

data "kms_key" "lambda_key" {
    key_id = "alias/aws/lambda"
}