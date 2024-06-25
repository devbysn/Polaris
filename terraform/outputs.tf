output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpcs
}

output "bastion_host" {
  description = "The ID of the VPC"
  value       = var.bastion_host
}

output "bastion_ssh_key" {
  description = "The ID of the VPC"
  value       = var.bastion_ssh_key
}

output "bastion_user" {
  description = "The ID of the VPC"
  value       = var.bastion_user
}

output "cluster_endpoint" {
  description = "The ID of the VPC"
  value       = module.eks.cluster_endpoint
}

output "cluster_id" {
  description = "The ID of the VPC"
  value       = module.eks.cluster_id
}

output "cluster_certificate_authority_data" {
  description = "The ID of the VPC"
  value       = module.eks.cluster_certificate_authority_data
}
