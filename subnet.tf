resource "aws_subnet" "m-sub-1" {
  provider          = aws.region-master
  vpc_id            = aws_vpc.master.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = element(data.aws_availability_zones.azs-m.names, 0)

  tags = {
    Name = "public-sub-1"
  }
}

resource "aws_subnet" "m-sub-2" {
  provider          = aws.region-master
  vpc_id            = aws_vpc.master.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = element(data.aws_availability_zones.azs-m.names, 1)

  tags = {
    Name = "public-sub-2"
  }
}
resource "aws_subnet" "w-sub-1" {
  provider          = aws.region-worker
  vpc_id            = aws_vpc.worker.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = element(data.aws_availability_zones.azs-w.names, 0)

  tags = {
    Name = "public-worker-sub-1"
  }
}
