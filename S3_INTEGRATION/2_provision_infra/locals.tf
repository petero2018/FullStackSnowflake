locals {
  common_tags = (tomap({
    Terraform   = "true"
    Project     = var.project_name
    Repository  = "not pushed yet"
  }))
}