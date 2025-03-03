# Configure AWS Provider
provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Create Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2b"
  tags = {
    Name = "public-subnet"
  }
}

# Create Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "private-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Create Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "public-route-table"
  }
}

# Associate Public Subnet with Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# Add Internet Access Route to Route Table
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Create Security Group for VyOS
resource "aws_security_group" "vyos_sg" {
  name        = "vyos-security-group"
  description = "Allow SSH and required VyOS services"
  vpc_id      = aws_vpc.main.id

  # Allow SSH (Port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow WebUI (If Needed)
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow All Outbound Traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vyos-sg"
  }
}

# Create VyOS Instance
resource "aws_instance" "vyos" {
  ami           = "ami-077dd7d9c71a48c89"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.public.id
  key_name      = "my-aws-key"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.vyos_sg.id]

  tags = {
    Name = "VyOS-router"
  }
}

# Fetch the Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create Amazon Linux Instance in the Private Subnet
resource "aws_instance" "private_test_instance" {
  ami           = data.aws_ami.amazon_linux.id  # Automatically fetch latest Amazon Linux 2 AMI
  instance_type = "t3.micro"  # Keeping it micro unless performance issues arise
  subnet_id     = aws_subnet.private.id
  key_name      = "my-aws-key"

  # Security group allowing SSH only from VyOS
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  tags = {
    Name = "Private-Test-Instance"
  }
}

# Create Security Group for Private Instance
resource "aws_security_group" "private_sg" {
  name        = "private-instance-sg"
  description = "Allow SSH only from VyOS"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.1/32"]  # Allow SSH only from VyOS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg"
  }
}