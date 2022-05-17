####################
### Lambda Outputs##
####################
output "lambda_arn" {
  value = aws_lambda_function.string_replacer.arn
}
output "lambda_name" {
  value = aws_lambda_permission.apigw.function_name
}
output "lambda_cwlog_group_arn" {
  value = aws_cloudwatch_log_group.string_replacer_log_group.arn
}
####################
### Api GW Outputs##
####################
output "api_id" {
  value = aws_api_gateway_rest_api.string_replacer_api.id
}
output "api_resouce_name" {
  value = aws_api_gateway_resource.string_replace_api_resource.path
}
output "api_arn" {
  value = aws_api_gateway_rest_api.string_replacer_api.arn
}
output "api_invoke_url" {
  value = aws_api_gateway_deployment.string_replace_api_deployment.invoke_url
}
output "api_key_value" {
  value = aws_api_gateway_api_key.string_replace_api_key.value
}