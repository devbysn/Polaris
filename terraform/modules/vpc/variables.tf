variable "vpc_parameters" {
  description = "VPC Parameters"
  type = map(object({
    cidr_block           = string
    enable_dns_support   = optional(bool, true)
    enable_dns_hostnames = optional(bool, true)
    tags                 = optional(map(string), {})
  }))

  default = {}
}

variable "subnet_parameters" {
  description = "Subnet Parameters"
  type = map(object({
    cidr_block = string
    vpc_name   = string
    tags       = optional(map(string), {})
  }))

  default = {}
}

variable "igw_parameters" {
  description = "IGW Parameters"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string), {})
  }))

  default = {}
}

variable "rt_parameters" {
  description = "Route Table Parameters"
  type = map(object({
    vpc_name = string,
    tags     = optional(map(string), {})
    routes = optional(list(object({
      cidr_block = string
      use_igw    = optional(bool, true)
      gateway_id = string
    })), [])
  }))
  default = {}
}

variable "rt_association_parameters" {
  description = "RT association parameters"
  type = map(object({
    subnet_name = string
    rt_name     = string
  }))
  default = {}
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}


variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

