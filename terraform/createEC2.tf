resource "aws_instance" "kul" {
  ami = "ami-0b3dec44fdc13daaf"
  instance_type = "t2.micro"
  key_name = "kul-ericsson-thinknyx"
  tags = {
    "Name" = "thinknyx-${var.tagName}"
  } 
}