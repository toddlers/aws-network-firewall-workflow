resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    description = "http from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
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

  tags = {
    Name = "allow_http"
  }
}

resource "aws_key_pair" "terraform-demo" {
  key_name   = "aws-network-firewall"
  public_key = file(var.ssh-key-full-path)
}

resource "aws_instance" "my-instance" {
  ami                         = var.ami-id
  instance_type               = var.instance-type
  key_name                    = aws_key_pair.terraform-demo.key_name
  user_data                   = file("install.sh")
  subnet_id                   = aws_subnet.application.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.allow_http.id]
  tags = {
    Name = "test-aws-network-firewall"
  }
}