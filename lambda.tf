##################################
# AWS Lambda funtion aws iam role#
##################################
resource "aws_iam_role" "lambda_exec" {
  name = format("%s-%s",var.resource_name_prefix,"iam-role")

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_policy" "function_logging_policy" {
  name   = "function-logging-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect : "Allow",
        Resource : "arn:aws:logs:*:*:*"
      }
    ]
  })
}
# resource "aws_iam_policy" "policy" {
#   name        = "test-policy"
#   description = "A test policy"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "s3:*"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
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

}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.string_replacer.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.string_replacer_api.execution_arn}/*/*"
}


resource "aws_cloudwatch_log_group" "string_replacer_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.string_replacer.function_name}"
  retention_in_days = 1
  lifecycle {
    prevent_destroy = false
  }
}