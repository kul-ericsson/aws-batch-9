resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}.10.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "thinknyx-${var.tagName}"
  }
}

resource "aws_subnet" "sn-1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${var.cidr_block}.10.10.0/24"
  availability_zone = "us-east-2a"
  tags = {
    "Name" = "thinknyx-${var.tagName}-public"
  }
  map_public_ip_on_launch = true
}
resource "aws_subnet" "sn-2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${var.cidr_block}.10.20.0/24"
  availability_zone = "us-east-2b"
  tags = {
    "Name" = "thinknyx-${var.tagName}-private"
  }
}
resource "aws_subnet" "sn-3" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${var.cidr_block}.10.30.0/24"
  availability_zone = "us-east-2c"
  tags = {
    "Name" = "thinknyx-${var.tagName}-private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "thinknyx-${var.tagName}"
  }
}

resource "aws_route_table" "igw_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "thinknyx-${var.tagName}-igw"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "igw_rt" {
  subnet_id = aws_subnet.sn-1.id
  route_table_id = aws_route_table.igw_rt.id
}

resource "aws_eip" "eip" {
  tags = {
    "Name" = "thinknyx-${var.tagName}"
  }
}

resource "aws_nat_gateway" "natgw" {
  subnet_id = aws_subnet.sn-1.id
  allocation_id = aws_eip.eip.id
  tags = {
    "Name" = "thinknyx-${var.tagName}"
  }
}

resource "aws_route_table" "natgw_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "thinknyx-${var.tagName}-natgw"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }
}

resource "aws_route_table_association" "natgw_rt_2" {
  subnet_id = aws_subnet.sn-2.id
  route_table_id = aws_route_table.natgw_rt.id
}
resource "aws_route_table_association" "natgw_rt_3" {
  subnet_id = aws_subnet.sn-3.id
  route_table_id = aws_route_table.natgw_rt.id
}
