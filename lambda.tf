terraform {
  backend "s3" {
  }
}
data "aws_caller_identity" "current" {}
###############################
# AWS Lambda funtion log group#
###############################
resource "aws_cloudwatch_log_group" "string_replacer_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.string_replacer.function_name}"
  retention_in_days = 1
  lifecycle {
    prevent_destroy = false
  }
}
##################################
# AWS Lambda funtion aws iam role#
##################################
resource "aws_iam_role" "lambda_exec" {
  name = format("%s-%s",var.resource_name_prefix,"iam-role")

  assume_role_policy = var.lambda_execution_role_assume_policy
}

resource "aws_iam_policy" "function_logging_policy" {
  depends_on = [
    aws_cloudwatch_log_group.string_replacer_log_group
  ]
  name   = format("%s-%s",var.resource_name_prefix,"function-logging-policy")
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect : "Allow",
        Resource : "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.string_replacer.function_name}:*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = format("%s-%s",var.resource_name_prefix,"logging-policy-attachment")
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = aws_iam_policy.function_logging_policy.arn
}
############################################
# AWS Lambda funtion with local source code#
############################################
resource "aws_lambda_function" "string_replacer" {
  function_name = format("%s-%s",var.resource_name_prefix,"function")
  handler = var.lambda_handler
  s3_bucket = var.lambda_code_s3_bucket
  s3_key    = var.lambda_code_s3_bucket_key
  description = var.lambda_description
  memory_size = var.lambda_memory_size
  runtime = var.lambda_runtime
  timeout = var.lambda_timeout
  role = aws_iam_role.lambda_exec.arn
  
  environment {
    variables = {
      replacer_words = var.replacer_words
    }
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.string_replacer.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.string_replacer_api.execution_arn}/*/*"
}