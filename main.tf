locals {
  common_tags = {
    environment = var.environment
    managedBy   = var.team
    createdBy   = "terraform"
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
  { Name = "EC2-${var.environment}" })
}