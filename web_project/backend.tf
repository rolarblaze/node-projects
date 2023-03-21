# store the terraform state file in an S3 bucket
terraform {
  backend "s3" {
    bucket = "my-node-app1973331"
    key = "value"
    region = "us-east-1"
    profile = "default"
  }
}