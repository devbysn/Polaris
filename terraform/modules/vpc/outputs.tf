output "vpcs" {
  value = {
    for vpc_name, vpc in aws_vpc.this : vpc_name => {
      id = vpc.id
    }
  }
}

output "subnets" {
  value = {
    for subnet_name, subnet in aws_subnet.this : subnet_name => {
      id = subnet.id
    }
  }
}

