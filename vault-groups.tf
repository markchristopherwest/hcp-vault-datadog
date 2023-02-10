# resource "vault_identity_group" "internal_dev" {
#   name                      = "internal"
#   type                      = "internal"
#   external_member_group_ids = true

#   metadata = {
#     version = "2"
#   }
# }

# resource "vault_identity_group" "users_dev" {
#   name = "users_dev"
#   metadata = {
#     version = "2"
#   }
# }

# resource "vault_identity_group_member_group_ids" "members_dev" {

#   exclusive         = true
#   member_group_ids = [vault_identity_group.users_dev.id]
#   group_id          = vault_identity_group.internal_dev.id
# }


# resource "vault_identity_group" "internal_prod" {
#   name                      = "internal"
#   type                      = "internal"
#   external_member_group_ids = true

#   metadata = {
#     version = "2"
#   }
# }

# resource "vault_identity_group" "users_prod" {
#   name = "users_prod"
#   metadata = {
#     version = "2"
#   }
# }

# resource "vault_identity_group_member_group_ids" "member_prod" {

#   exclusive         = true
#   member_group_ids = [vault_identity_group.users_prod.id]
#   group_id          = vault_identity_group.internal_prod.id
# }