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

# Política adicional para CloudWatch Logs (Managed Policy)
resource "aws_iam_policy" "ecs_logs_policy" {
  name        = "${var.ecs_task_execution_role_name}-logs-policy"
  description = "Policy for ECS tasks to create and write to CloudWatch logs"

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

  tags = {
    Name = "${var.ecs_task_execution_role_name}-logs-policy"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_logs" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_logs_policy.arn
}
