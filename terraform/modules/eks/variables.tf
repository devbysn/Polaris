variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs for the EKS cluster"
  type        = list(string)
}

