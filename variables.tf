variable "create_org" {
  description = "A flag defining whether to create an organization or not. Useful, if you want to have a separate module for nested Organizational Units (OUs)"
  type        = bool
  default     = true
}

variable "feature_set" {
  description = "After the Terraform docs: 'Specify ALL (default) or CONSOLIDATED_BILLING.'"
  default     = "ALL"
}

variable "aws_service_access_principals" {
  description = "After the Terraform docs: 'List of AWS service principal names for which you want to enable integration with your organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must have feature_set set to ALL. For additional information, see the AWS Organizations User Guide.'"
  type        = list(string)
  default     = null
}

variable "enabled_policy_types" {
  description = "After the Terraform docs: 'List of Organizations policy types to enable in the Organization Root. Organization must have feature_set set to ALL. For additional information about valid policy types (e.g. SERVICE_CONTROL_POLICY and TAG_POLICY), see the AWS Organizations API Reference.'"
  type        = list(string)
  default     = null
}

variable "organizational_units" {
  description = "A list of Organizational Units (OUs) to be created."
  type = list(object({
    name      = string
    parent_id = optional(string)
  }))
  default = null
}
