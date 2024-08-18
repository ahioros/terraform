# set locals
locals {
  type = "t2.micro"
  ami  = "ami-whatever"
  tags = {
    Project = "Example 4"
  }
  nic    = aws_network_interface.my_nic.id
  subnet = aws_subnet.mysubnet
}
