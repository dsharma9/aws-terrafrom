variable "master" {
  type    = string
  default = "us-east-1"
}
variable "worker" {
  type    = string
  default = "us-west-2"
}
variable "peer_owner_id" {
  type    = string
  default = "690834645538"
}

variable "worker-count" {
  type    = number
  default = 1
}

variable "region-master" {
  type    = string
  default = "us-east-1"
}
variable "region-worker" {
  type    = string
  default = "us-west-2"
}
variable "profile" {
  type    = string
  default = "default"
}
variable "ansible_user" {
  type    = string
  default = "ec2-user"
}
variable "private_key" {
  type    = string
  default = "~/.ssh/id_rsa"
}

variable "alb_port" {
  type    = number
  default = 80
}
variable "dns-name" {
  type    = string
  default = "cmcloudlab1611.info."
}
