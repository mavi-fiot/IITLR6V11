provider "aws" {
  region = "us-east-2"
  shared_credentials_files = ["C:/Users/MAVi/.aws/credentials"]
}

resource "aws_instance" "lr6ver12" {
    ami           = "ami-02bf8ce06a8ed6092"
    instance_type = "t2.micro"
  
    tags = {
        Name = "lr6ver12"
    }

    # Встановлення публічного IP-адреси
    associate_public_ip_address = true

    # Зв'язування з безпечною групою
    vpc_security_group_ids = [aws_security_group.example_security_group.id]
}

# Опис мережевих ресурсів
resource "aws_vpc" "example_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example_subnet" {
    vpc_id     = aws_vpc.example_vpc.id
    cidr_block = "10.0.1.0/24"
}

# Опис правил файрвола
resource "aws_security_group" "example_security_group" {
    name        = "example-security-group"
    description = "Allow inbound traffic on port 80"
  
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8030
        to_port     = 8030
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

