output "org" {
  description = "The whole organization object as described in the Terraform docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization#attributes-reference"
  value       = aws_organizations_organization.org
}

output "ou" {
  description = "The whole Organizational Unit (OU) object as described in the Terraform docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit#attributes-reference"
  value       = aws_organizations_organizational_unit.ou
}
