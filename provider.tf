# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = "~> 2.0"
#     }
#     helm = {
#       source  = "hashicorp/helm"
#       version = "~> 2.0"
#     }
#   }
#   backend "s3" {
#     bucket = "nome-do-bucket-12345"
#     key    = "dev/terraform.tfstate"
#     region = "us-east-1"
#   }
# }
#
# provider "aws" {
#   region  = "us-east-1"
#   profile = "renato_admin"
# }
