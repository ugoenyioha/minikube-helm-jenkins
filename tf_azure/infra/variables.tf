variable resource_group_name {
  default = "jenkins_helm"
}

variable location {
  default = "westus2"
}

variable "ssh_public_key" {
  default = "~/.ssh/server_rsa.pub"
}

variable "ssh_private_key" {
  default = "~/.ssh/server_rsa"
}

variable "dns_prefix" {
  default = "jenkins"
}

variable cluster_name {
  default = "jenkins"
}

variable "agent_count" {
  default = 3
}

variable "azure_client_id" {}

variable "azure_client_secret" {}

variable "azure_subscription_id" {}

variable "azure_tenant_id" {}

variable "storage_account_name" {}
variable "container_name" {}
variable "key" {}
variable "access_key" {}