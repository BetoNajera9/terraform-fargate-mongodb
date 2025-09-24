resource "aws_cloudwatch_event_rule" "ecr_when_push_rule" {
  name        = var.rule_name
  description = "EventBridge rule for ${var.rule_name}"
  state       = var.state

  event_pattern = {
    "source" : ["aws.ecr"],                         // Qué servicio AWS emite el evento
    "detail-type" : ["ECR Image Action"],           // Tipo específico de evento
    "detail" : {                                    // Detalles internos del evento
      "action-type" : ["PUSH"],                     // Acción específica
      "result" : ["SUCCESS"],                       // Estado del resultado
      "repository-name" : [var.ecr_repository_name] // Filtros adicionales
    }
  }

  tags = {
    Name = var.rule_name
  }
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.ecr_when_push_rule.name
  target_id = var.lambda_function_id
  arn       = var.lambda_function_arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge-${var.lambda_function_id}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ecr_when_push_rule.arn
}
