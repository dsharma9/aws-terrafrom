resource "aws_route_table" "master-rt" {
  provider = aws.region-master
  vpc_id   = aws_vpc.master.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-master.id
  }
  route {
    cidr_block                = "192.168.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.master-2-worker.id
  }

  tags = {
    Name = "Master-RT"
  }
}
resource "aws_route_table_association" "master-subnet-rt-association" {
  provider = aws.region-master
  subnet_id      = aws_subnet.m-sub-1.id
  route_table_id = aws_route_table.master-rt.id
}

resource "aws_route_table_association" "master-subnet-rt-association-2" {
  provider = aws.region-master
  subnet_id      = aws_subnet.m-sub-2.id
  route_table_id = aws_route_table.master-rt.id
}


# RT for worker
resource "aws_route_table" "worker-rt" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.worker.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-worker.id
  }
  route {
    cidr_block                = "10.10.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.master-2-worker.id
  }
  tags = {
    Name = "Worker-RT"
  }
}
resource "aws_route_table_association" "worker-subnet-rt-association" {
  provider = aws.region-worker
  subnet_id      = aws_subnet.w-sub-1.id
  route_table_id = aws_route_table.worker-rt.id
}



# merging main RT of Master
resource "aws_main_route_table_association" "master-main-rt" {
  provider       = aws.region-master
  vpc_id         = aws_vpc.master.id
  route_table_id = aws_route_table.master-rt.id
}
# merging main RT of worker 
resource "aws_main_route_table_association" "worker-main-rt" {
  provider       = aws.region-worker
  vpc_id         = aws_vpc.worker.id
  route_table_id = aws_route_table.worker-rt.id
}


