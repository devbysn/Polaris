variable "cluster_endpoint" {
  description = "The endpoint for your EKS cluster"
  type        = string
}

variable "kubernetes_token" {
  description = "The Kubernetes authentication token"
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "The CA certificate for your EKS cluster"
  type        = string
}

variable "namespace" {
  description = "The Kubernetes namespace in which to deploy Jenkins"
  type        = string
  default     = "jenkins"
}



# -------********------------------------
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
