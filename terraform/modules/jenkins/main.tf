resource "null_resource" "ssh_tunnel" {
  provisioner "local-exec" {
    command = "ssh -i ${var.bastion_ssh_key} -L 6443:${var.cluster_endpoint}:443 -N -f ${var.bastion_user}@${var.bastion_host}"
  }
}

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.kubernetes_token
    cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  }
}

resource "helm_release" "jenkins" {
  depends_on = [null_resource.ssh_tunnel]

  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"

  namespace        = var.namespace
  create_namespace = true

  values = [
    <<EOF
controller:
  installPlugins:
    - kubernetes
    - workflow-aggregator
    - git
    - configuration-as-code
  service:
    type: LoadBalancer
EOF
  ]
}
