#trivy:ignore:AVD-AWS-0028
#trivy:ignore:AVD-AWS-0131
resource "aws_instance" "webserver_test" {
  ami           = "whateveravalidami"
  instance_type = "t2.micro"
  tags = {
    Name = "webserver_test"
  }
}

#trivy:ignore:AVD-AWS-0028
#trivy:ignore:AVD-AWS-0131
resource "aws_instance" "database_server_test" {
  ami           = "whateveravalidami"
  instance_type = "t2.micro"
  tags = {
    Name = "database_server_test"
  }
}
