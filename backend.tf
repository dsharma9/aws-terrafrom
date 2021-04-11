terraform {
  backend "s3" {
    bucket = "abc-1234567890-abc-1234567890"
    key    = "state"
    region = "us-east-1"
  }
}
