variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "subnet_private_1a" {
  type        = string
  description = "The ID of the private subnet in availability zone 1a"
}

variable "subnet_private_1b" {
  type        = string
  description = "The ID of the private subnet in availability zone 1b"
}
