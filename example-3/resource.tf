resource "tls_private_key" "webserver_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.webserver_private_key.private_key_pem
  filename        = "webserver_key.pem"
  file_permission = 0400
}

# add key to aws file
resource "aws_key_pair" "webserver_key" {
  key_name   = "webserver"
  public_key = tls_private_key.webserver_private_key.public_key_openssh
}

resource "aws_instance" "bastion_host" {
  ami                         = "ami-whatever"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = aws_key_pair.webserver_key.key_name
  vpc_security_group_ids      = [aws_security_group.bastion_ssh.id]
  associate_public_ip_address = true
  tags = {
    Name = "bastion_host"
  }
}

# webserver
resource "aws_instance" "webserver" {
  ami                         = "ami-whatever"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = aws_key_pair.webserver_key.key_name
  vpc_security_group_ids      = [aws_security_group.webserver_http.id]
  associate_public_ip_address = true
  tags = {
    Name = "webserver"
  }
}

# mysql
resource "aws_instance" "mysql_server" {
  ami                    = "ami-whatever"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  key_name               = aws_key_pair.webserver_key.key_name
  vpc_security_group_ids = [aws_security_group.security_group_mysql.id]
  tags = {
    Name = "mysql"
  }
}