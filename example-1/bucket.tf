resource "aws_s3_bucket" "bucket" {
  bucket = "usertest1234-bucket"

  tags = merge({
    Name    = "Bucket de usertest"
    Project = "User Test Project"
    region  = "us-east-1"
  })
}