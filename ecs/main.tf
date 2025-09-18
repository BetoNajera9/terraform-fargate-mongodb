resource "aws_ecs_cluster" "main_ecs" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.cluster_name
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.cluster_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets[1]
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = false
  }

  # load_balancer {
  #   target_group_arn = var.alb_target_arn
  #   container_name   = var.container_name
  #   container_port   = var.container_port
  # }

  depends_on = [aws_ecs_task_definition.this]
}
