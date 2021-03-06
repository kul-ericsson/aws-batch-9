resource "aws_instance" "kul" {
  ami = "ami-0b3dec44fdc13daaf"
  instance_type = "t2.micro"
  key_name = "kul-ericsson-thinknyx"
  tags = {
    "Name" = "thinknyx-${var.tagName}"
  }
  vpc_security_group_ids = [ aws_security_group.sg.id ]
}

resource "aws_security_group" "sg" {
  vpc_id = data.aws_vpc.vpc.id
  description = "Managed by Terraform"
  name = "thinknyx-${var.tagName}"
  tags = {
    "Name" = "thinknyx-${var.tagName}"
  }
  ingress {
    description = "SSH Port"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP Port"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "EFS Port"
    protocol = "tcp"
    from_port = 2049
    to_port = 2049
    cidr_blocks = [ data.aws_vpc.vpc.cidr_block ]
  }
  egress {
    description = "All open Out bound traffic"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

