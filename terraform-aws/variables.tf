variable "environment" {
  description = "Deployment environment (dev or prod)"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be 'dev' or 'prod'."
  }
}

variable "organization" {
  description = "GitHub organization name, used in resource tags and repository URL"
  type        = string
  default     = "SthoreH"
}

variable "github_repository" {
  description = "GitHub repository name"
  type        = string
  default     = "app-aws-lbd-products-service"
}

variable "lambda_zip_path" {
  description = "Absolute path to the Lambda .zip artifact produced by the CD pipeline. Defaults to empty so terraform destroy works without rebuilding the artifact."
  type        = string
  default     = ""
}
