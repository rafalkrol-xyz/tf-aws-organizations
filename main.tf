resource "aws_organizations_organization" "org" {
  count = var.create_org ? 1 : 0

  feature_set                   = var.feature_set
  aws_service_access_principals = var.feature_set == "ALL" ? var.aws_service_access_principals : null
  enabled_policy_types          = var.feature_set == "ALL" ? var.enabled_policy_types : null
}

resource "aws_organizations_organizational_unit" "ou" {
  count = length(var.organizational_units)

  name      = var.organizational_units[count.index].name
  parent_id = var.organizational_units[count.index].parent_id != null ? var.organizational_units[count.index].parent_id : aws_organizations_organization.org.roots.0.id
}
