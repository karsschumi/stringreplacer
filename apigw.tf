########################
### API Gateway#########
########################
resource "aws_api_gateway_rest_api" "string_replacer_api" {
    
    name = format("%s-%s",var.resource_name_prefix,"api")
    description = "API for ${var.resource_name_prefix}"

    endpoint_configuration {
      types = ["REGIONAL"]
    }
  
}

########################
### API Gateway KEY####
########################
resource "aws_api_gateway_api_key" "string_replace_api_key" {
  name = format("%s-%s",var.resource_name_prefix,"api-key")
}

############################
### API Gateway resource####
############################
resource "aws_api_gateway_resource" "string_replace_api_resource" {
  
  rest_api_id = aws_api_gateway_rest_api.string_replacer_api.id
  parent_id = aws_api_gateway_rest_api.string_replacer_api.root_resource_id
  path_part = var.resources_and_methods["resource_path_part"]
  
}


##########################
### API Gateway method####
##########################
resource "aws_api_gateway_method" "string_replace_api_method" {
  
  rest_api_id = aws_api_gateway_rest_api.string_replacer_api.id
  resource_id = aws_api_gateway_resource.string_replace_api_resource.id
  http_method  = var.resources_and_methods["http_method"]
  api_key_required = true
  authorization = "NONE"
}

#####################################
### API Gateway method integration###
#####################################
resource "aws_api_gateway_integration" "string_replace_api_method_integration" {
  
  rest_api_id = aws_api_gateway_rest_api.string_replacer_api.id
  resource_id = aws_api_gateway_resource.string_replace_api_resource.id
  http_method  = aws_api_gateway_method.string_replace_api_method.http_method
  
  integration_http_method = var.resources_and_methods["integration_http_method"]
  type = var.resources_and_methods["integration_type"]
  uri = aws_lambda_function.string_replacer.invoke_arn
}


resource "aws_api_gateway_deployment" "string_replace_api_deployment" {

  depends_on = [
    "aws_api_gateway_integration.string_replace_api_method_integration"
  ]

  rest_api_id = aws_api_gateway_rest_api.string_replacer_api.id
  stage_name  = var.api_gateway_deployment_stage_name
  
  triggers = {redeployment = sha1(jsonencode([
      aws_api_gateway_resource.string_replace_api_resource.path_part,
      aws_api_gateway_method.string_replace_api_method.id,
      aws_api_gateway_integration.string_replace_api_method_integration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }


}



resource "aws_api_gateway_usage_plan" "string_replace_usage_plan" {
  name = format("%s-%s",var.resource_name_prefix,"usage-plan")

  api_stages {
    api_id = aws_api_gateway_rest_api.string_replacer_api.id
    stage  = aws_api_gateway_deployment.string_replace_api_deployment.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_and_key" {
  key_id        = aws_api_gateway_api_key.string_replace_api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.string_replace_usage_plan.id
}
