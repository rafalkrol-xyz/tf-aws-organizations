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
* [tflint](https://github.com/terraform-linters/tflint)
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
