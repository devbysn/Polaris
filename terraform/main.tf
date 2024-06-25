module "vpc" {
  source = "./modules/vpc"

  vpc_parameters = {
    project_vpc = {
      cidr_block           = "10.0.0.0/16"
      enable_dns_support   = true
      enable_dns_hostnames = true
      tags = {
        Environment = "dev"
      }
    }
  }

  subnet_parameters = {
    public_subnet_1 = {
      cidr_block = "10.0.1.0/24"
      vpc_name   = "project_vpc"
      tags = {
        Type = "public"
      }
    }
    public_subnet_2 = {
      cidr_block = "10.0.2.0/24"
      vpc_name   = "project_vpc"
      tags = {
        Type = "public"
      }
    }
    public_subnet_3 = {
      cidr_block = "10.0.3.0/24"
      vpc_name   = "project_vpc"
      tags = {
        Type = "public"
      }
    }
    private_subnet_1 = {
      cidr_block = "10.0.4.0/24"
      vpc_name   = "project_vpc"
      tags = {
        Type = "private"
      }
    }
    private_subnet_2 = {
      cidr_block = "10.0.5.0/24"
      vpc_name   = "project_vpc"
      tags = {
        Type = "private"
      }
    }
    private_subnet_3 = {
      cidr_block = "10.0.6.0/24"
      vpc_name   = "project_vpc"
      tags = {
        Type = "private"
      }
    }
  }

  igw_parameters = {
    igw_1 = {
      vpc_name = "project_vpc"
      tags = {
        Name = "project_vpc_igw"
      }
    }
  }

  rt_parameters = {
    public_rt = {
      vpc_name = "project_vpc"
      tags = {
        Name = "public_rt"
      }
      routes = [{
        cidr_block = "0.0.0.0/0"
        use_igw    = true
        gateway_id = "igw_1"
      }]
    }
  }

  rt_association_parameters = {
    public_subnet_1_association = {
      subnet_name = "public_subnet_1"
      rt_name     = "public_rt"
    }
    public_subnet_2_association = {
      subnet_name = "public_subnet_2"
      rt_name     = "public_rt"
    }
    public_subnet_3_association = {
      subnet_name = "public_subnet_3"
      rt_name     = "public_rt"
    }
  }

  azs = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

module "eks" {
  source = "./modules/eks"

  cluster_name = "my-private-eks-cluster"
  private_subnet_ids = [
    module.vpc.subnets["private_subnet_1"].id,
    module.vpc.subnets["private_subnet_2"].id,
    module.vpc.subnets["private_subnet_3"].id
  ]
}


# ----------------------------------

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "jenkins" {
  source = "./modules/jenkins"

  # cluster_endpoint                   = module.eks.cluster_endpoint
  # kubernetes_token                   = data.aws_eks_cluster_auth.cluster.token
  # cluster_certificate_authority_data = module.eks.cluster_certificate_authority_data
  # namespace                          = "jenkins"

  # ---------------------
  cluster_endpoint                   = module.eks.cluster_endpoint
  kubernetes_token                   = data.aws_eks_cluster_auth.cluster.token
  cluster_certificate_authority_data = module.eks.cluster_certificate_authority_data
  namespace                          = "jenkins"
  bastion_host                       = var.bastion_host
  bastion_user                       = var.bastion_user
  bastion_ssh_key                    = var.bastion_ssh_key

}

# output "jenkins_url" {
#   value = module.jenkins.jenkins_url
# }
