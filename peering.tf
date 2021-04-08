resource "aws_vpc_peering_connection" "master-2-worker" {
  provider      = aws.region-master
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.worker.id
  vpc_id        = aws_vpc.master.id
  peer_region   = "us-west-2"

  tags = {
    Name = "Master-to-Worker"
  }
}

# Accepter, will be created in Worker region. 
resource "aws_vpc_peering_connection_accepter" "peer-worker" {
  provider                  = aws.region-worker
  vpc_peering_connection_id = aws_vpc_peering_connection.master-2-worker.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}
