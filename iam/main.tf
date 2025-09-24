resource "aws_iam_role" "ecs_task_execution" {
  name        = var.ecs_task_execution_role_name
  description = "IAM role for ECS task execution with CloudWatch logging capabilities"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = var.ecs_task_execution_role_name
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Additional policy to allow ECS tasks to create and write to CloudWatch logs
resource "aws_iam_role_policy" "ecs_logs_policy" {
  name = "${var.ecs_task_execution_role_name}-logs-policy"
  role = aws_iam_role.ecs_task_execution.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups"
        ]
        Resource = [
          "arn:aws:logs:*:*:log-group:/ecs/*",
          "arn:aws:logs:*:*:log-group:/ecs/*:*"
        ]
      }
    ]
  })
}

# Lambda policy and role
resource "aws_iam_role" "lambda_deployment_strategy_role" {
  name = var.lambda_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = var.lambda_role_name
  }
}

resource "aws_iam_role_policy" "lambda_deployment_strategy_policy" {
  name = "${var.lambda_role_name}-log-policy"
  role = aws_iam_role.lambda_deployment_strategy_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat([
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups"
        ],
        Resource = [
          "arn:aws:logs:*:*:log-group:/lambda/*",
          "arn:aws:logs:*:*:log-group:/lambda/*:*"
        ]
      }
    ])
  })
}
