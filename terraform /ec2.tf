
resource "aws_key_pair" "instance_key" {
  key_name   = "jenkin-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJuacKJ2oXVjahgWvf23TmrLGU/AjUPqhruoEV7R2P+E macbookpro@macbooks-MacBook-Pro-2.local"
}


resource "aws_instance" "my_public_instance" {
 
  ami                         = local.Environment.public_instance_ami
  instance_type               = local.Environment.public_instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [ aws_security_group.my_public_sg.id]
  key_name                    = aws_key_pair.instance_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "jen_task3_pub_${terraform.workspace}"
  }
  depends_on = [module.vpc]
}

resource "aws_instance" "my_private_instance" {
 
  ami                    = local.Environment.private_instance_ami
  instance_type          = local.Environment.private_instance_type
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.my_private_sg.id, aws_security_group.my_public_sg.id]
  key_name               = aws_key_pair.instance_key.key_name
  tags = {
    Name = "jen_task3_priv_${terraform.workspace}"
  }
  depends_on = [module.vpc]
}