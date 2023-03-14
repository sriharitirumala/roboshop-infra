variable "instances" {}
variable "env" {}
mongodb = {
  name = "mongodb"
  type = "t3.micro"
}
user = {
  name = "user"
  type = "t3.small"
}
frontend = {
  name = "frontend"
  type = "t3.small"
}
cart = {
  name = "cart"
  type = "t3.small"
}
rabbitmq = {
  name = "rabbitmq"
  type = "t3.small"
}
catalogue = {
  name = "catalogue"
  type = "t3.small"
}
rabbitmq = {
  name = "rabbitmq"
  type = "t3.small"
  password = "roboshop123"
}
mysql = {
  name = "mysql"
  type = "t3.small"
  password = "RoboShop@1"
}
shipping = {
  name = "shipping"
  type = "t3.small"
  password = "RoboShop@1"
}
payment = {
  name = "payment"
  type = "t3.small"
  password = "roboshop123"
}
}
}
