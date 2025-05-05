variable "environment" {
  type = string
}
variable "team" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "subnet_id" {
  type = list(string)
}
variable "filter_name" {
  type = string
}
variable "number_of_ec2" {
  type = number
}