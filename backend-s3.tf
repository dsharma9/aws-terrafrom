terraform {
  backend "s3" {
    bucket = "s3-terraform-state-file-123456789"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }


}
