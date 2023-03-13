variable "instances" {
  default = {
    backend = {
      name = "backend"
      type = "t3.micro"
    }
  }
}