#trivy:ignore:AVD-AWS-0086
#trivy:ignore:AVD-AWS-0087
#trivy:ignore:AVD-AWS-0088
#trivy:ignore:AVD-AWS-0089
#trivy:ignore:AVD-AWS-0090
#trivy:ignore:AVD-AWS-0091
#trivy:ignore:AVD-AWS-0093
#trivy:ignore:AVD-AWS-0094
#trivy:ignore:AVD-AWS-0132
resource "aws_s3_bucket" "bucket" {
  bucket = "usertest1234-bucket"

  tags = merge({
    Name    = "Bucket de usertest"
    Project = "User Test Project"
    region  = "us-east-1"
  })
}
