variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "deployment-strategy"
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "deployment-strategy.lambda_handler"
}

# Refused from IAM module
variable "iam_lambda_deployment_strategy_role_arn" {
  description = "ARN del rol de ejecución de Lambda"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}
