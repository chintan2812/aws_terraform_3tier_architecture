resource "aws_eip" "myeip" {
  instance = aws_instance.web[0].id  # Assuming "web" is the name of your EC2 instance
  vpc      = true
}
