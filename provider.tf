provider "aws" {
	region = "us-east-1"
	alias = "region-master"
}

provider "aws" {
	region = "us-west-2"
	alias = "region-worker"
}
