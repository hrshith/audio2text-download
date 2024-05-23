# Configure the AWS provider
provider "aws" {
  region = "ap-south-1" # Mumbai region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

variable "aws_access_key_id" {
  description = "AWS access key ID"
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
  type        = string
}

# Create a security group to allow inbound traffic on port 5000
resource "aws_security_group" "allow_port_5000" {
  name        = "allow-port-5000"
  description = "Allow inbound traffic on port 5000"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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

# Create an EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-0f58b397bc5c1f2e8" # Ubuntu 24.04 LTS in Mumbai region
  instance_type = "t2.large"

  root_block_device {
    volume_size = 30 # Increase root volume size to 30GB
  }

  vpc_security_group_ids = [aws_security_group.allow_port_5000.id]

  user_data = <<-EOF
              #!/bin/bash
              # Install Docker
              sudo apt-get update
              sudo apt-get install -y docker.io

              # Start Docker service
              sudo systemctl start docker
              sudo systemctl enable docker

              # Pull and run the Docker container on port 5000
              sudo docker run -d -p 5000:5000 cbcb00/audio2txt:latest
              EOF

  tags = {
    Name = "audio2txt-server"
  }
}

# Output the public IP address of the EC2 instance
output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}
