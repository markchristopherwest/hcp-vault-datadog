# terraform {
#   required_providers {
#     hcp = {
#       source = "hashicorp/hcp"
#       version = "0.53.0"
#     }
#     vault = {
#       source = "hashicorp/vault"
#       version = "3.12.0"
#     }
#   }
# }
# provider "vault" {
#   # Configuration options
#   token = hcp_vault_cluster_admin_token.example.token
#   address = hcp_vault_cluster.example.vault_public_endpoint_url
# }