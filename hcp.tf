terraform {
  required_providers {
    hcp = {
      source = "hashicorp/hcp"
      version = "0.53.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "3.12.0"
    }
  }
}

provider "hcp" {
  # Configuration options
}
# provider "vault" {
#   # Configuration options
#   # token = hcp_vault_cluster_admin_token.example.token
#   # address = hcp_vault_cluster.example.vault_public_endpoint_url
# }

variable "datadog_api_key" {
 type = string
 default = "XO"
 description = "DataDog API Key"
}

variable "datadog_region" {
 type = string
 default = "us5"
 description = "DataDog Region"
}

variable "datadog_site" {
 type = string
 default = "us5.datadoghq.com"
 description = "DataDog Site"
}

resource "random_pet" "hvn" {
  length = 2
#   count  = length(var.users) / 2
  separator = "-"
}

resource "hcp_hvn" "example" {
  hvn_id         = random_pet.hvn.id
  cloud_provider = "aws"
  region         = "us-west-2"
  cidr_block     = "172.25.16.0/20"
}

resource "hcp_vault_cluster" "example" {
  cluster_id = random_pet.hvn.id
  hvn_id     = hcp_hvn.example.hvn_id
  tier       = "standard_large"
#   metrics_config {
#     datadog_api_key = var.datadog_api_key
#     datadog_region  = "us-west-2"
#   }
#   audit_log_config {
#     datadog_api_key = var.datadog_api_key
#     datadog_region  = var.datadog_site
#   }
  lifecycle {
    prevent_destroy = false
  }
}

resource "hcp_vault_cluster_admin_token" "example" {
  cluster_id = hcp_vault_cluster.example.cluster_id
}

output "hcp_vault_cluster_admin_token" {
  value = hcp_vault_cluster_admin_token.example.token
  sensitive = true
}

output "hcp_vault_cluster_url" {
  value = hcp_vault_cluster.example.vault_public_endpoint_url
  sensitive = true
}

# # Create a new Datadog API Key
# resource "datadog_api_key" "foo" {
#   name = hcp_hvn.example.hvn_id
# }