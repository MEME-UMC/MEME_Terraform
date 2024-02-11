resource "aws_api_gateway_rest_api" "meme_gateway" {
  name = "MemeGateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "api" {
  parent_id   = aws_api_gateway_rest_api.meme_gateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.meme_gateway.id
  path_part   = "api"
}

resource "aws_api_gateway_resource" "v0" {
  rest_api_id = aws_api_gateway_rest_api.meme_gateway.id
  parent_id   = aws_api_gateway_resource.api.id
  path_part   = "v0"
}

resource "aws_api_gateway_resource" "v1" {
  rest_api_id = aws_api_gateway_rest_api.meme_gateway.id
  parent_id   = aws_api_gateway_resource.api.id
  path_part   = "v1"
}


resource "aws_api_gateway_resource" "proxy0" {
  rest_api_id = aws_api_gateway_rest_api.meme_gateway.id
  parent_id   = aws_api_gateway_resource.v0.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.meme_gateway.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "api_proxy0" {
  rest_api_id   = aws_api_gateway_rest_api.meme_gateway.id
  resource_id   = aws_api_gateway_resource.proxy0.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method" "api_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.meme_gateway.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}


resource "aws_api_gateway_integration" "ApiV0Integration" {
  rest_api_id          = aws_api_gateway_rest_api.meme_gateway.id
  resource_id          = aws_api_gateway_resource.proxy0.id
  http_method          = aws_api_gateway_method.api_proxy0.http_method
  type                 = "HTTP_PROXY"
  uri                  = "http://${aws_eip.meme_auth_ec2.public_ip}:8080/api/v0/{proxy}"
  integration_http_method = "ANY"

  cache_key_parameters = ["method.request.path.proxy"]

  timeout_milliseconds = 29000
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

resource "aws_api_gateway_integration" "ApiV1Integration" {
  rest_api_id          = aws_api_gateway_rest_api.meme_gateway.id
  resource_id          = aws_api_gateway_resource.proxy.id
  http_method          = aws_api_gateway_method.api_proxy.http_method
  type                 = "HTTP_PROXY"
  uri                  = "http://${aws_eip.meme_service_ec2.public_ip}:8080/api/v1/{proxy}"
  integration_http_method = "ANY"

  cache_key_parameters = ["method.request.path.proxy"]

  timeout_milliseconds = 29000
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

resource "aws_api_gateway_deployment" "meme_gateway" {
  depends_on  = [
    aws_api_gateway_integration.ApiV0Integration, aws_api_gateway_integration.ApiV1Integration,
    aws_api_gateway_integration.auth_integration, aws_api_gateway_integration.service_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.meme_gateway.id
  stage_name    = "prod"
}