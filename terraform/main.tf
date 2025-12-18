resource "aws_security_group" "insecure_sg" {
  name        = "insecure-sg"
  description = "Security group with intentional vulnerability"

  ingress {
    description = "Allow SSH from anywhere (INSECURE)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ❌ INTENTIONAL SECURITY ISSUE
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
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
resource "aws_instance" "web_server" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.insecure_sg.name]

  tags = {
    Name = "DevOps-Insecure-Server"
  }
}
