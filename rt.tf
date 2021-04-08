resource "aws_route_table" "master-rt" {
  provider = aws.region-master
  vpc_id = aws_vpc.master.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-master.id
  }

  tags = {
    Name = "Master-RT"
  }
}

# RT for worker
resource "aws_route_table" "worker-rt" {
  provider = aws.region-worker
  vpc_id = aws_vpc.worker.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-worker.id
  }

  tags = {
    Name = "Worker-RT"
  }
}


# merging main RT of Master
resource "aws_main_route_table_association" "master-main-rt" {
  provider = aws.region-master
  vpc_id         = aws_vpc.master.id
  route_table_id = aws_route_table.master-rt.id
}
# merging main RT of worker 
resource "aws_main_route_table_association" "worker-main-rt" {
  provider = aws.region-worker
  vpc_id         = aws_vpc.worker.id
  route_table_id = aws_route_table.worker-rt.id
}
