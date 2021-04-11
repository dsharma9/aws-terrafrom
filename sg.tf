# SG for ALB
resource "aws_security_group" "alb" {
  provider    = aws.region-master
  name        = "ALB"
  description = "Allow TLS and http inbound traffic"
  vpc_id      = aws_vpc.master.id

  ingress {
    description = "TLS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Traffic from internet"
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

  tags = {
    Name = "allow-traffice-alb"
  }
}



# SG for Master Jenkins
resource "aws_security_group" "sg-jenkins-master" {
  provider    = aws.region-master
  name        = "jenkins-master"
  description = "Allow inbound traffic from ELB on 8080 and Jenkins worker on 22"
  vpc_id      = aws_vpc.master.id

  ingress {
    description     = "Allow inbound traffic from ELB on 8080"
    from_port       = var.alb_port
    to_port         = var.alb_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    description = "Allow inbound traffic from Jenkins worker on port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow inbound traffic from Jenkins worker"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_traffice-elb-jenkins-worker"
  }
}

# SG for Worker Jenkins
resource "aws_security_group" "sg-jenkins-worker" {
  provider    = aws.region-worker
  name        = "jenkins-worker"
  description = "Allow inbound traffic from Jenkins master on 22"
  vpc_id      = aws_vpc.worker.id

  ingress {
    description = "Allow ssh on 22 from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all traffice from Subnet-1 elb"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_traffice-from-jenkins-master"
  }
}
