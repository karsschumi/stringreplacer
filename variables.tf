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
  
}
variable "lambda_function_logging_policy" {
  
}
####################
# Lambda variables #
####################
variable "lambda_handler" {
description = "value"  
}
variable "lambda_code_s3_bucket" {
  description = "value"
}
variable "lambda_code_s3_bucket_key" {
  description = "value"
}
variable "lambda_description" {
  description = "value"
}
variable "lambda_memory_size" {
  description = "value"
}
variable "lambda_timeout" {
  description = "value"
}
variable "lambda_runtime" {
  description = "value"
}


#################
# API variables #
#################
variable "resources_and_methods" {
  description = "value"
}
variable "api_gateway_deployment_stage_name" {
  description = "value"
}
