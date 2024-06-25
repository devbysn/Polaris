variable "bastion_host" {
  description = "The public DNS or IP of the bastion host"
  type        = string
}

variable "bastion_user" {
  description = "The SSH user for the bastion host"
  type        = string
}

variable "bastion_ssh_key" {
  description = "The path to the SSH private key for the bastion host"
  type        = string
}
