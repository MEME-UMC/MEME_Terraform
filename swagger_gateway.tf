resource "aws_api_gateway_resource" "auth" {
  parent_id   = aws_api_gateway_rest_api.meme_gateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.meme_gateway.id
  path_part   = "auth"
}

resource "aws_api_gateway_resource" "service" {
  parent_id   = aws_api_gateway_rest_api.meme_gateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.meme_gateway.id
  path_part   = "service"
}

resource "aws_api_gateway_resource" "auth_swagger_proxy" {
  rest_api_id = aws_api_gateway_rest_api.meme_gateway.id
  parent_id   = aws_api_gateway_resource.auth.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_resource" "service_swagger_proxy" {
  rest_api_id = aws_api_gateway_rest_api.meme_gateway.id
  parent_id   = aws_api_gateway_resource.service.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "auth_proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.meme_gateway.id
  resource_id   = aws_api_gateway_resource.auth_swagger_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method" "service_proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.meme_gateway.id
  resource_id   = aws_api_gateway_resource.service_swagger_proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "auth_integration" {
  rest_api_id          = aws_api_gateway_rest_api.meme_gateway.id
  resource_id          = aws_api_gateway_resource.auth_swagger_proxy.id
  http_method          = aws_api_gateway_method.auth_proxy_method.http_method
  type                 = "HTTP_PROXY"
  uri                  = "http://${aws_eip.meme_auth_ec2.public_ip}:8080/auth/{proxy}"
  integration_http_method = "ANY"

  cache_key_parameters = ["method.request.path.proxy"]

  timeout_milliseconds = 29000
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

resource "aws_api_gateway_integration" "service_integration" {
  rest_api_id          = aws_api_gateway_rest_api.meme_gateway.id
  resource_id          = aws_api_gateway_resource.service_swagger_proxy.id
  http_method          = aws_api_gateway_method.service_proxy_method.http_method
  type                 = "HTTP_PROXY"
  uri                  = "http://${aws_eip.meme_service_ec2.public_ip}:8080/service/{proxy}"
  integration_http_method = "ANY"

  cache_key_parameters = ["method.request.path.proxy"]

  timeout_milliseconds = 29000
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}