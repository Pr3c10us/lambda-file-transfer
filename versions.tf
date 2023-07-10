terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.4.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.1"
    }
  }
}
