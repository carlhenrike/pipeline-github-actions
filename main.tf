terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.61.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
  }


  backend "azurerm" {
    resource_group_name  = "rg-remote-state"
    storage_account_name = "stiaccountstate"
    container_name       = "remote-state"
    key                  = "pipeline-github-actions/terraform.state"
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-remote-state"
    storage_account_name = "stiaccountstate"
    container_name       = "remote-state"
    key                  = "azure-vnet/terraform.state"
  }
} 


provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      owner      = "carlos"
      managed-by = "terraform"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "full-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}