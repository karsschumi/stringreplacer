region = "eu-central-1"
access_key = ""
secret_key = ""
resource_name_prefix = "string-replacer"
lambda_execution_role_assume_policy = <<EOF
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
lambda_function_logging_policy = <<EOF
{
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
}
EOF
lambda_handler = "lambda_function.lambda_handler"
lambda_code_s3_bucket = "string-replacer-code"
lambda_code_s3_bucket_key = "v2.0.0/python_string_replacer.zip"
lambda_description = "lambda does a find and replace for certain words and outputs the result. For example: replace Google for Google©."
lambda_memory_size = 128
lambda_timeout = 10
lambda_runtime = "python3.8"
replacer_words = "Amazon,Deloitte,Google,Oracle,Microsoft"
resources_and_methods = {resource_path_part = "stringreplacer", http_method = "POST", integration_http_method = "POST",integration_type = "AWS_PROXY"}
api_gateway_deployment_stage_name = "prod"