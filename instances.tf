data "aws_ssm_parameter" "ami-master" {
  provider = aws.region-master
  name     = "/aws/service/ami-amazon-linux-latest/amzn-ami-hvm-x86_64-gp2"
}
data "aws_ssm_parameter" "ami-worker" {
  provider = aws.region-worker
  name     = "/aws/service/ami-amazon-linux-latest/amzn-ami-hvm-x86_64-gp2" 
}

resource "aws_key_pair" "master-key" {
  provider   = aws.region-master
  key_name   = "jenkins"
  public_key = file("~/.ssh/id_rsa.pub")
}
resource "aws_key_pair" "worker-key" {
  provider   = aws.region-worker
  key_name   = "jenkins"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Jenkins master in subnet 1
resource "aws_instance" "jenkins-master" {
  provider                    = aws.region-master
  ami                         = data.aws_ssm_parameter.ami-master.value
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.sg-jenkins-master.id]
  key_name                    = aws_key_pair.master-key.id
  subnet_id                   = aws_subnet.m-sub-1.id

  tags = {
    Name = "jenkins-master"
  }
}

# Jenkins worker in subnet 1 us-west-2
resource "aws_instance" "jenkins-worker" {
  provider                    = aws.region-worker
  ami                         = data.aws_ssm_parameter.ami-worker.value
  count                       = var.worker-count
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.sg-jenkins-worker.id]
  key_name                    = aws_key_pair.worker-key.id
  subnet_id                   = aws_subnet.w-sub-1.id

  tags = {
    Name = join("_", ["jenkins-worker", count.index + 1])
  }
}
