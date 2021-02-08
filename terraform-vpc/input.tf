variable "tagName" {
  description = "Type the the String you would like to use as TagName"
  type = string
}
variable "cidr_block" {
  description = "Type first entry of CIDR Block for VPC to be created, between 0-255 other than 10"
  type = string
}