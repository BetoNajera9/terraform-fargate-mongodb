variable "rule_name" {
  description = "Name of the EventBridge rule"
  type        = string
}

variable "state" {
  description = "State of the rule (ENABLED or DISABLED)"
  type        = string

  validation {
    condition     = contains(["ENABLED", "DISABLED"], var.state)
    error_message = "State must be either ENABLED or DISABLED"
  }
}

# Refused from ECR module
variable "ecr_repository_name" {
  description = "Name of the ECR repository to monitor for image push events"
  type        = string
}

# Refused from Lambda module
variable "lambda_function_arn" {
  description = "ARN of the Lambda function to trigger on ECR image push"
  type        = string
}

variable "lambda_function_id" {
  description = "ID of the Lambda function to trigger on ECR image push"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to grant permissions"
  type        = string
}
