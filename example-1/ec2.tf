resource "aws_instance" "webserver_test" {
  ami           = "whateveravalidami"
  instance_type = "t2.micro"
  tags = {
    Name = "webserver_test"
  }
}

resource "aws_instance" "database_server_test" {
  ami           = "whateveravalidami"
  instance_type = "t2.micro"
  tags = {
    Name = "database_server_test"
  }
}