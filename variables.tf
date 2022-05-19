####################
# Common variables #
####################
variable "resource_name_prefix"{
    description = "Name prefix to be used for all the resources"
}
#################
# IAM variables #
#################
variable "lambda_execution_role_assume_policy" {
   description = "Policy that grants an lambda permission to assume the role"
}
variable "lambda_function_logging_policy" {
  description = "Policy that grants an lambda to push logs to cloudwatch"

}
####################
# Lambda variables #
####################
variable "lambda_handler" {
description = "Function entrypoint in the code"  
}
variable "lambda_code_s3_bucket" {
  description = " S3 bucket location containing the function's deployment package"
}
variable "lambda_code_s3_bucket_key" {
  description = "S3 key of an object containing the function's deployment package"
}
variable "lambda_description" {
  description = "Description of what the Lambda Function does"
}
variable "lambda_memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
}
variable "lambda_timeout" {
  description = "Amount of time your Lambda Function has to run in seconds"
}
variable "lambda_runtime" {
  description = "Identifier of the function's runtime"
}
variable "replacer_words" {
  description = "Words that are to be replaced"
}


#################
# API variables #
#################
variable "resources_and_methods" {
  description = "API Gateway Resources and method details as a map"
}
variable "api_gateway_deployment_stage_name" {
  description = "Name of the stage to create with the deployment"
}
