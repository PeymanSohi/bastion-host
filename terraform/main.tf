resource "aws_instance" "bastion" {
  ami           = var.bastion_ami
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "BastionHost"
  }

  associate_public_ip_address = true
  subnet_id                   = <PUBLIC_SUBNET_ID>
  security_groups             = [aws_security_group.bastion_sg.name]
}

resource "aws_instance" "private" {
  ami           = var.private_ami
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "PrivateServer"
  }

  subnet_id       = <PRIVATE_SUBNET_ID>
  security_groups = [aws_security_group.private_sg.name]
}
