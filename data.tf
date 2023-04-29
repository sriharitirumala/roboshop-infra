data "aws_ssm_parameter" "ssh_pass" {
  name = "${var.env}.ssh.pass"
}



data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "ami-02c073b6f8c9e1803"
  owners      = ["self"]
}


#data "aws_ami" "ami" {
#  most_recent = true
#  name_regex  = "devops-practice-with-ansible"
#  owners      = ["self"]
#}
