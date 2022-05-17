region = "us-east-1"
access_key = ""
secret_key = ""
resource_name_prefix = "string-replacer"
lambda_handler = "lambda_function.lambda_handler"
lambda_code_s3_bucket = "string-replacer-artifacts"
lambda_code_s3_bucket_key = "v1.0.0/python_string_replacer.zip"
lambda_description = "lambda does a find and replace for certain words and outputs the result. For example: replace Google for Google©."
lambda_memory_size = 128
lambda_timeout = 10
lambda_runtime = "python3.8"
resources_and_methods = {resource_path_part = "stringreplacer", http_method = "POST", integration_http_method = "POST",integration_type = "AWS_PROXY"}
api_gateway_deployment_stage_name = "prod"