resource "aws_security_group" "nexgensis_sg" {
  name        = "nexgensis-sg"
  description = "security group to allow ports"
  ingress {

    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
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

resource "aws_key_pair" "nexgensis_key" {
  key_name   = "nexgensis_key"
  public_key = file("nexgensis.pub")
}

resource "aws_instance" "web_server" {
  ami             = "ami-02b8269d5e85954ef"
  instance_type   = "t3.small"
  key_name        = aws_key_pair.nexgensis_key.key_name
  security_groups = [aws_security_group.nexgensis_sg.name]

  tags = {
    name = "web-server"
  }
}