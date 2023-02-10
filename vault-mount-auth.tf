# # https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend#dev-usage
# resource "vault_auth_backend" "approle" {
#   type = "approle"
# }

# # https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_login#dev-usage
# resource "vault_approle_auth_backend_role" "dev" {
#   backend         = vault_auth_backend.approle.path
#   role_name       = "dev-role"
#   token_policies  = ["default", "dev"]
# }

# resource "vault_approle_auth_backend_role_secret_id" "dev" {
#   backend   = vault_auth_backend.approle.path
#   role_name = vault_approle_auth_backend_role.dev.role_name
# }

# resource "vault_approle_auth_backend_login" "login_dev" {
#   backend   = vault_auth_backend.approle.path
#   role_id   = vault_approle_auth_backend_role.dev.role_id
#   secret_id = vault_approle_auth_backend_role_secret_id.dev.secret_id
# }

# resource "vault_auth_backend" "dev" {
#   type = "userpass"

#   tune {
#     max_lease_ttl      = "90000s"
#     listing_visibility = "unauth"
#   }
# }

# # https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_login#prod-usage
# resource "vault_approle_auth_backend_role" "prod" {
#   backend         = vault_auth_backend.approle.path
#   role_name       = "prod-role"
#   token_policies  = ["default", "prod"]
# }

# resource "vault_approle_auth_backend_role_secret_id" "prod" {
#   backend   = vault_auth_backend.approle.path
#   role_name = vault_approle_auth_backend_role.prod.role_name
# }

# resource "vault_approle_auth_backend_login" "login_prod" {
#   backend   = vault_auth_backend.approle.path
#   role_id   = vault_approle_auth_backend_role.prod.role_id
#   secret_id = vault_approle_auth_backend_role_secret_id.prod.secret_id
# }

# resource "vault_auth_backend" "prod" {
#   type = "userpass"

#   tune {
#     max_lease_ttl      = "90000s"
#     listing_visibility = "unauth"
#   }
# }