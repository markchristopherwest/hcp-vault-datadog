# resource "vault_egp_policy" "allow-all" {
#   name              = "allow-all"
#   paths             = ["*"]
#   enforcement_level = "soft-mandatory"

#   policy = <<EOT
# main = rule {
#   true
# }
# EOT
# }

# # https://developer.hashicorp.com/vault/tutorials/policies/sentinel#requirement-1-check-for-the-business-hours
# resource "vault_egp_policy" "allow-working-hours" {
#   name              = "allow-working-hours"
#   paths             = ["*"]
#   enforcement_level = "soft-mandatory"

#   policy = <<EOT
# import "time"

# # Expect requests to only happen during work days (Monday through Friday)
# # 0 for Sunday and 6 for Saturday
# workdays = rule {
#     time.now.weekday > 0 and time.now.weekday < 6
# }

# # Expect requests to only happen during work hours (7:00 am - 6:00 pm)
# workhours = rule {
#     time.now.hour > 7 and time.now.hour < 18
# }

# main = rule {
#     workdays and workhours
# }
# EOT
# }


# # https://github.com/hashicorp/vault-guides/blob/master/governance/sentinel/inline-iam-actions.sentinel
# resource "vault_egp_policy" "inline_iam_actions" {
#   name              = "inline_iam_actions"
#   paths             = ["*"]
#   enforcement_level = "soft-mandatory"

#   policy = <<EOT
# # EGP policy meant for path aws/roles/*
# # Restrict inline IAM policy to only designate ec2 Actions

# import "strings"
# import "json"

# # Check for only ec2 actions
# check_action = func(a) {
#   if !(a matches "^ec2:") {
#     print("Action", a, "is not allowed.")
#     return false
#   } else {
#     print("Action", a, "is allowed.")
#     return true
#   }
# }

# policy_match = func() {
#   # Make sure there is request data
#   if length(request.data else 0) is 0 {
#     print("No request data")
#     return false
#   }

#   # Make sure there is a policy_document
#   if "policy_document" not in keys(request.data) {
#     print("No policy_document")
#     return false
#   }

#   # Debug data
#   #print("DATA:", request.data)
#   #print("KEYS:", keys(request.data))
#   #print("DOC:", request.data.policy_document)
#   #print("TYPE:", request.data.credential_type)

#   # Convert stringified policy into JSON
#   payload = json.unmarshal(request.data.policy_document)
#   #print("JSON:", payload)

#   # Iterate through all Statements and their Actions
#   for payload.policy_document.Statement as statement {
#     for statement.Action as action {
#       return check_action(action)
#     }
#   }

#   return true
# }

# # Rule applies to creating/updating AWS Vault roles (uses default path)
# precond = rule {
# 	request.operation in ["create", "update"] and
# 	strings.has_prefix(request.path, "aws/roles/")
# }

# # Main rule
# main = rule when precond {
# 	policy_match()
# }
# EOT
# }

# # https://github.com/hashicorp/vault-guides/blob/master/governance/sentinel/inline-iam-resources.sentinel
# resource "vault_egp_policy" "inline_iam_resources" {
#   name              = "inline_iam_resources"
#   paths             = ["*"]
#   enforcement_level = "soft-mandatory"

#   policy = <<EOT
# # EGP policy meant for path aws/roles/*
# # Restrict inline IAM policy from using a wildcard AWS account in Resources

# import "strings"
# import "json"

# # Check for no wildcard AWS account IDs
# check_resource = func(r) {
#   if r matches "arn:aws:iam::\\*" {
#     print("Resource", r, "AWS account wildcard is not allowed.")
#     return false
#   } else if r == "*" {
#     print("Resource", r, "wildcard is not allowed.")
#     return false
#   } else {
#     print("Resource", r, "AWS account specified.")
#     return true
#   }
# }

# policy_match = func() {
#   # Make sure there is request data
#   if length(request.data else 0) is 0 {
#     print("No request data")
#     return false
#   }

#   # Make sure there is a policy_document
#   if "policy_document" not in keys(request.data) {
#     print("No policy_document")
#     return false
#   }

#   # Debug data
#   #print("DATA:", request.data)
#   #print("KEYS:", keys(request.data))
#   #print("DOC:", request.data.policy_document)
#   #print("TYPE:", request.data.credential_type)

#   # Convert stringified policy into JSON
#   payload = json.unmarshal(request.data.policy_document)
#   #print("JSON:", payload)

#   # Iterate through all Statements and their Resources
#   for payload.policy_document.Statement as statement {
#     for statement.Resource as resource {
#       return check_resource(resource)
#     }
#   }

#   return true
# }

# # Rule applies to creating/updating AWS Vault roles (uses default path)
# precond = rule {
# 	request.operation in ["create", "update"] and
# 	strings.has_prefix(request.path, "aws/roles/")
# }

# # Main rule
# main = rule when precond {
# 	policy_match()
# }
# EOT
# }


# # https://developer.hashicorp.com/vault/docs/enterprise/sentinel/examples#mfa-and-cidr-check-on-login
# resource "vault_egp_policy" "mfa_cidr_check" {
#   name              = "mfa_cidr_check"
#   paths             = ["*"]
#   enforcement_level = "soft-mandatory"

#   policy = <<EOT
# import "sockaddr"
# import "mfa"
# import "strings"

# # We expect logins to come only from our private IP range
# cidrcheck = rule {
#     sockaddr.is_contained("10.20.0.0/16", request.connection.remote_addr)
# }

# # Require Ping MFA validation to succeed
# ping_valid = rule {
#     mfa.methods.ping.valid
# }

# main = rule when strings.has_prefix(request.path, "auth/ldap/login") {
#     ping_valid and cidrcheck
# }
# EOT
# }



# # https://developer.hashicorp.com/vault/docs/enterprise/sentinel/examples#allow-only-specific-identity-entities-or-groups
# resource "vault_egp_policy" "specific_ids_groups" {
#   name              = "specific_ids_groups"
#   paths             = ["*"]
#   enforcement_level = "soft-mandatory"

#   policy = <<EOT
# main = rule {
#     identity.entity.name is "jeff" or
#     identity.entity.id is "fe2a5bfd-c483-9263-b0d4-f9d345efdf9f" or
#     "sysops" in identity.groups.names or
#     "14c0940a-5c07-4b97-81ec-0d423accb8e0" in keys(identity.groups.by_id)
# }

# EOT
# }


# # resource "vault_rgp_policy" "allow-some" {
# #   name              = "allow-some"
# #   enforcement_level = "soft-mandatory"

# #   policy = <<EOT
# # main = rule {
# #   true
# # }
# # EOT
# # }

# # resource "vault_rgp_policy" "allow-all" {
# #   name              = "allow-all"
# #   enforcement_level = "soft-mandatory"

# #   policy = <<EOT
# # main = rule {
# #   true
# # }
# # EOT
# # }