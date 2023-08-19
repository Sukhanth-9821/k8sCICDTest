terraform {
  backend "s3" {
    bucket = "terraform-bucket023456"
    key    = "path/tfstatefile-eks"
    region = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
  }
}