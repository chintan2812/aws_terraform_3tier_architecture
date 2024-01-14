resource "aws_instance" "web" {
  ami           = "ami-0d3f444bc76de0a79"
  instance_type = "t2.micro"
  key_name = "master111"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "WebServer"
  }
  provisioner "file" {
    source = "./master111.pem"
    destination = file("G:/Learning/Sazan/Terraform/AWS_3tier_architecture_terraform/master111.pem")
  
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = file("master111.pem")
    }
  }
}
resource "aws_instance" "db" {
  ami           = "ami-0d3f444bc76de0a79"
  instance_type = "t2.micro"
  key_name = "master111"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}
