resource "aws_vpc" "master" {
  provider             = aws.region-master
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Master-VPC"
  }
}
#worker VPC in us-west-2 region
resource "aws_vpc" "worker" {
  provider             = aws.region-worker
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Worker-VPC"
  }
}

# List of AZ's in Master
data "aws_availability_zones" "azs-m" {
  provider = aws.region-master
  state    = "available"
}
# List of AZ's in worker 
data "aws_availability_zones" "azs-w" {
  provider = aws.region-worker
  state    = "available"
}


# IGW for Master
resource "aws_internet_gateway" "igw-master" {
  provider = aws.region-master
  vpc_id   = aws_vpc.master.id

  tags = {
    Name = "IGW-Master"
  }
}

# IGW for Worker 
resource "aws_internet_gateway" "igw-worker" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.worker.id

  tags = {
    Name = "IGW-Worker"
  }
}
