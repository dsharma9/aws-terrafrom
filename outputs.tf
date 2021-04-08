output "Jenkins-Master-public_ip" {
  value = aws_instance.jenkins-master.public_ip
}

output "Jenkins-Master-private_ip" {
  value = aws_instance.jenkins-master.private_ip
}

output "Jenkins-Worker-public_ip" {
  value = {
    for instance in aws_instance.jenkins-worker :
    instance.id => instance.public_ip
  }
}

output "Jenkins-Worker-private_ip" {
  value = {
    for instance in aws_instance.jenkins-worker :
    instance.id => instance.private_ip
  }
}
