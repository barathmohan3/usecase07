provider "aws" {
  region = "eu-west-1"
}

module "iam" {
    source = "./modules/iam"
    role_name = "lambda_exec_role"
}

module "lambda" {
    source = "./modules/lambda"
    function_name = "helloworldtest"
    image_uri  = "650251701672.dkr.ecr.eu-west-1.amazonaws.com/bsbs:latest"
    role_arn = module.iam.role_arn
}

module "apigateway" {
    source = "./modules/api_gateway"
    api_name = "hellowrold-test"
    route_key = "GET /"
    lambda_invoke_arn = module.lambda.invoke_arn
    lambda_arn = module.lambda.arn

}
