# output "jenkins_url" {
#   description = "URL of the Jenkins installation"
#   value       = helm_release.jenkins.status[0].url
# }

output "kubernetes_token" {
  value = var.kubernetes_token
}
