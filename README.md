# HCP Vault Datadog

Challenge: get the HCP Vault sending Audit Logs & Telemetry to DataDog:

https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster#example-usage

```hcl
resource "hcp_hvn" "example" {
  hvn_id         = "hvn"
  cloud_provider = "aws"
  region         = "us-west-2"
  cidr_block     = "172.25.16.0/20"
}

resource "hcp_vault_cluster" "example" {
  cluster_id = "vault-cluster"
  hvn_id     = hcp_hvn.example.hvn_id
  tier       = "standard_large"
  metrics_config {
    datadog_api_key = "test_datadog"
    datadog_region  = "us1"
  }
  audit_log_config {
    datadog_api_key = "test_datadog"
    datadog_region  = "us1"
  }
  lifecycle {
    prevent_destroy = true
  }
}
```
# Getting Started

You'll need to sign up for an HCP Account (it's free to start):

https://portal.cloud.hashicorp.com/sign-up

From there, you'll need to generate Users:

https://developer.hashicorp.com/hcp/docs/hcp/admin/users

```sh

export HCP_CLIENT_ID=XO

export HCP_CLIENT_SECRET=XO

terraform init

terraform apply

```

From your HCP Vault Portal, get the external URL of HCP Vault & set to:

export VAULT_ADDR=https://my-hcp-vault-public-endpoint

From your HCP Vault Portal, generate an Admin Token from HCP Vault & set to:

export VAULT_TOKEN=XO

After you have set these environment variables, uncomment the TF code in the vault*.tf files.

Terraform will connect to your HCP Vault & configure it using IaC.

HCP Vault Cluster is created.  This allows you to have a dev or test environment.  In this space you can test things like:
1. DataDog Integration so you can forward Audit data
1. Create Groups by linking together Identities & reduce client count
1. Apply Sentinel Policy to Restrict by IAM Role Tag, Mount, Business Hours, etc.

