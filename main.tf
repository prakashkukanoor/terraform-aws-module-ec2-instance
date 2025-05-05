locals {
  common_tags = {
    environment = var.environment
    managedBy   = var.team
    createdBy   = "terraform"
  }
}

resource "aws_security_group" "allow_all_traffic" {
  name   = "allow-all-traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.filter_name]
  }
}

resource "aws_instance" "this" {
  count = var.number_of_ec2 

  ami           = data.aws_ami.this.id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_id, count.index)

  tags = merge(
    local.common_tags,
  { Name = "EC2-${count.index+1}-${var.environment}" })
}