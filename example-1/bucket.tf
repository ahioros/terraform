resource "aws_s3_bucket" "bucket" {
  bucket = "guillu-bucket"

  tags = merge({
    Name    = "Bucket de Guillo"
    Project = "Proyecto de test"
    region  = "us-east-1"

  })

}