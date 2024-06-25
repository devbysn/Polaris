resource "aws_instance" "bastion" {
  ami           = "ami-0e1d06225679bc1c5"
  instance_type = "t2.micro"

  subnet_id = module.vpc.subnets["public_subnet_1"].id

  tags = {
    Name = "bastion-host"
  }

  key_name = "satya" 

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  associate_public_ip_address = true 
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH access"

  vpc_id = module.vpc.vpcs["project_vpc"].id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_eip" "bastion_eip" {
#   instance = aws_instance.web.id
#   domain   = "vpc"
# }
# resource "aws_eip_association" "bastion_eip_assoc" {
#   instance_id   = aws_instance.bastion.id
#   # allocation_id = aws_eip.bastion_eip.id
# }

