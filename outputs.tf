output "id" {
  description = "After the Terraform docs: 'Identifier of the organization'"
  value       = aws_organizations_organization.org.id
}

output "accounts" {
  description = "After the Terraform docs: 'List of organization accounts including the master account. (...)'"
  value       = aws_organizations_organization.org.accounts
}

output "roots" {
  description = "After the Terraform docs: 'List of organization roots. (...)'"
  value       = aws_organizations_organization.org.roots
}

# output "org" {
#   description = "The whole organization object as defined in the Terraform docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization#attributes-reference"
#   value       = aws_organizations_organization.org
# }
