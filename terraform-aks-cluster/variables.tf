variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}

variable "resource_group_name" {
  description = "Resource group name for AKS"
  type        = string
  default     = "allianz"
}
