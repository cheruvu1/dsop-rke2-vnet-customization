variable "cloud" {
  description = "Which Azure cloud to use"
  type        = string
  default     = "AzureUSGovernmentCloud"
  validation {
    condition     = contains(["AzureUSGovernmentCloud", "AzurePublicCloud"], var.cloud)
    error_message = "Allowed values for cloud are \"AzureUSGovernmentCloud\" or \"AzurePublicCloud\"."
  }
}

variable "server_public_ip" {
  description = "Assign a public IP to the control plane load balancer"
  type        = bool
  default     = true
}

variable "server_open_ssh_public" {
  description = "Allow SSH to the server nodes through the control plane load balancer"
  type        = bool
  default     = false
}

variable "vm_size" {
  type    = string
  default = "Standard_D8_v3"
}

variable "server_instance_count" {
  type    = number
  default = 1
}

variable "agent_instance_count" {
  type    = number
  default = 2
}

variable "cluster_name" {
  type = string
}

variable "location" {
  type    = string
  default = "usgovvirginia"
}

variable "subnet_cidr" {
  description = "kubernetes internal service cidr range"
  default     = "10.0.1.0/24"
}

variable "address_space" {
  description = "Network address space"
  default     = "10.0.0.0/16"
}

variable "use_external_vnet" {
  description = "Use existing Virtual Network"
  type        = bool
  default     = false
}

variable "external_vnet_name" {
  description = "Existing Virtual Network name"
  type        = string
  default     = ""
}

variable "external_vnet_resource_group" {
  description = "Existing Virtual Network name"
  type        = string
  default     = ""
}

variable "external_vnet_subnet_name" {
  description = "Existing VNET subnet name"
  type        = string
  default     = "default"
}