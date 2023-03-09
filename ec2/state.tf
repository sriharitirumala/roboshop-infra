resource "aws_instance" "example" {
  instance_type = "t2.micro"
  ami           = "ami-021d05dce32577bf3"
  $ terraform import aws_instance.example

}
