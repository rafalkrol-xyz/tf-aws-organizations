output "org" {
  description = "The whole organization object as described in the Terraform docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization#attributes-reference"
  value       = var.create_org ? aws_organizations_organization.0.org : null
}

output "ou_ids" {
  description = "The identifiers (IDs) of the Organizational Unit(s) (OU) if created"
  type        = list(string)
  value       = aws_organizations_organizational_unit.ou.*.id
}
