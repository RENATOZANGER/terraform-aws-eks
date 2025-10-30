variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources"
}
