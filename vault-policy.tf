# resource "vault_policy" "example" {
#   name = "example-team"

#   policy = <<EOT
# path "kvv2" {
#   capabilities = ["update"]
# }
# EOT
# }

# # https://developer.hashicorp.com/vault/docs/concepts/policies#policy-syntax
# resource "vault_policy" "dev" {
#   name = "dev-team"

#   policy = <<EOT
# path "secret/foo" {
#   capabilities = ["read"]
# }

# EOT
# }

# # https://developer.hashicorp.com/vault/docs/concepts/policies#capabilities
# resource "vault_policy" "prod" {
#   name = "prod-team"

#   policy = <<EOT
# # This section grants all access on "secret/*". Further restrictions can be
# # applied to this broad policy, as shown below.
# path "secret/*" {
#   capabilities = ["create", "read", "update", "patch", "delete", "list"]
# }

# # Even though we allowed secret/*, this line explicitly denies
# # secret/super-secret. This takes precedence.
# path "secret/super-secret" {
#   capabilities = ["deny"]
# }

# # Policies can also specify allowed, disallowed, and required parameters. Here
# # the key "secret/restricted" can only contain "foo" (any value) and "bar" (one
# # of "zip" or "zap").
# path "secret/restricted" {
#   capabilities = ["create"]
#   allowed_parameters = {
#     "foo" = []
#     "bar" = ["zip", "zap"]
#   }
# }

# EOT

# }

# # https://developer.hashicorp.com/vault/docs/concepts/policies#capabilities
# resource "vault_policy" "path_based" {
#   name = "path-based"

#   policy = <<EOT
# # Permit reading only "secret/foo". An attached token cannot read "secret/food"
# # or "secret/foo/bar".
# path "secret/foo" {
#   capabilities = ["read"]
# }

# # Permit reading everything under "secret/bar". An attached token could read
# # "secret/bar/zip", "secret/bar/zip/zap", but not "secret/bars/zip".
# path "secret/bar/*" {
#   capabilities = ["read"]
# }

# # Permit reading everything prefixed with "zip-". An attached token could read
# # "secret/zip-zap" or "secret/zip-zap/zong", but not "secret/zip/zap
# path "secret/zip-*" {
#   capabilities = ["read"]
# }


# EOT
# }

# # https://developer.hashicorp.com/vault/docs/concepts/policies#examples

# resource "vault_policy" "template_based" {
#   name = "template-based"

#   policy = <<EOT
# # In the example below, the group ID maps a group and the path
# path "secret/data/groups/{{identity.groups.ids.fb036ebc-2f62-4124-9503-42aa7A869741.name}}/*" {
#   capabilities = ["create", "update", "patch", "read", "delete"]
# }

# path "secret/metadata/groups/{{identity.groups.ids.fb036ebc-2f62-4124-9503-42aa7A869741.name}}/*" {
#   capabilities = ["list"]
# }

# EOT
# }

