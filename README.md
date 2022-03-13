# Terraform AWS Organizations

## Overview

This is a parametrized [Terraform module](https://learn.hashicorp.com/tutorials/terraform/module) for creating [AWS Organizations resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users.html)
such as [the organization itself, Organizational Units (OUs) and accounts](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html).

## Prerequisites

* [AWS IAM user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users.html) with adequate privileges
* [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) that's properly [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
* [Terraform](https://www.terraform.io/)
  * NB you can use [`tfswitch`](https://tfswitch.warrensbox.com/) to manage different versions of Terraform

### Prerequisites for pre-commit-terraform

**a)** dependencies

The [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform) util requires the latest versions of the following dependencies:

* [pre-commit](https://pre-commit.com/#install)
* [terraform-docs](https://github.com/terraform-docs/terraform-docs)
* [tfsec](https://github.com/aquasecurity/tfsec)
* [terrascan](https://github.com/accurics/terrascan)

On macOS, you can install the above with [brew](https://brew.sh/):

```bash
brew install pre-commit terraform-docs tflint tfsec terrascan
```

**b)** usage

The tool will run automatically before each commit if [git hooks scripts](https://pre-commit.com/#3-install-the-git-hook-scripts) are installed in the project's root:

```bash
pre-commit install
```

For a manual run, execute the below command:

```bash
pre-commit run -a
```

**NB the configuration file is located in `.pre-commit-config.yaml`**

## Usage

```terraform
TODO: add accounts!!!!
module "root" {
  source = "git@github.com:rafalkrol-xyz/tf-aws-organizations.git?ref=init"
  enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "member.org.stacksets.cloudformation.amazonaws.com",
  ]
  organizational_units = [
    {
      name      = "core"
    },
    {
      name      = "workloads"
    },
  ]
}

module "nested" {
  source = "git@github.com:rafalkrol-xyz/tf-aws-organizations.git?ref=init"
  create_org = false
  organizational_units = [
    {
      name      = "nested"
      parent_id = module.root.ou_ids["core"]
    },
  ]
}
```

### Note on tags

[Starting from AWS Provider for Terraform v3.38.0 (with Terraform v0.12 or later onboard), you may define default tags at the provider level, streamlining tag management](https://www.hashicorp.com/blog/default-tags-in-the-terraform-aws-provider).
The functionality replaces the now redundant per-resource tags configurations, and therefore, this module has dropped the support of a `tags` variable.
Instead, set the default tags in your parent module:

```terraform
FIXME: update the below!!!
### PARENT MODULE - START
locals {
  tags = {
    key1   = "value1"
    key2   = "value2"
    keyN   = "valueN"
  }
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = local.tags
  }
}

# NB the default tags are implicitly passed into the module: https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags
module "break_glass" {
  source        = "git@github.com:rafalkrol-xyz/tf-aws-iam-user.git?ref=v1.0.0"
  name          = "break-glass"
  groups        = [aws_iam_group.administrators.name]
  force_destroy = true
  pgp_key       = "keybase:YOUR_KEYBASE_USERNAME" # Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username.
}
### PARENT MODULE - END
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_organizational_unit.ou](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_service_access_principals"></a> [aws\_service\_access\_principals](#input\_aws\_service\_access\_principals) | After the Terraform docs: 'List of AWS service principal names for which you want to enable integration with your organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must have feature\_set set to ALL. For additional information, see the AWS Organizations User Guide.' | `list(string)` | `null` | no |
| <a name="input_create_org"></a> [create\_org](#input\_create\_org) | A flag defining whether to create an organization or not. Useful, if you want to have a separate module for nested Organizational Units (OUs) | `bool` | `true` | no |
| <a name="input_enabled_policy_types"></a> [enabled\_policy\_types](#input\_enabled\_policy\_types) | After the Terraform docs: 'List of Organizations policy types to enable in the Organization Root. Organization must have feature\_set set to ALL. For additional information about valid policy types (e.g. SERVICE\_CONTROL\_POLICY and TAG\_POLICY), see the AWS Organizations API Reference.' | `list(string)` | `null` | no |
| <a name="input_feature_set"></a> [feature\_set](#input\_feature\_set) | After the Terraform docs: 'Specify ALL (default) or CONSOLIDATED\_BILLING.' | `string` | `"ALL"` | no |
| <a name="input_organizational_units"></a> [organizational\_units](#input\_organizational\_units) | A list of Organizational Units (OUs) to be created. | <pre>list(object({<br>    name      = string<br>    parent_id = optional(string)<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_org"></a> [org](#output\_org) | The whole organization object as described in the Terraform docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization#attributes-reference |
| <a name="output_ou_ids"></a> [ou\_ids](#output\_ou\_ids) | A map of Organizational Units (OUs) names and their identifiers (IDs) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
