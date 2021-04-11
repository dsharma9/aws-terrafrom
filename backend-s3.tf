terraform {
  backend "s3" {
    bucket = "s3-terraform-state-file-123456789-mini"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }


}
