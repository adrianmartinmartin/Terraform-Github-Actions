resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_prefix}.0.0/16"
  enable_dns_hostnames = true
  tags = {
     Name = "${var.prefix}-${var.cidr_prefix}-vpc"
     }
}

resource "aws_subnet" "public-subnet0" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.cidr_prefix}.0.0/24"
  availability_zone = data.aws_availability_zones.az.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-${var.cidr_prefix}-public-subnet0"
  }
}

resource "aws_subnet" "public-subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.cidr_prefix}.1.0/24"
  availability_zone = data.aws_availability_zones.az.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-${var.cidr_prefix}-public-subnet1"
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.cidr_prefix}.2.0/24"
  availability_zone = data.aws_availability_zones.az.names[2]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-${var.cidr_prefix}-public-subnet2"
  }
}

resource "aws_subnet" "private-subnet0" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.cidr_prefix}.100.0/24"
  availability_zone = data.aws_availability_zones.az.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.prefix}-${var.cidr_prefix}-private-subnet0"
  }
}

resource "aws_subnet" "private-subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.cidr_prefix}.101.0/24"
  availability_zone = data.aws_availability_zones.az.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.prefix}-${var.cidr_prefix}-private-subnet1"
  }
}

resource "aws_subnet" "private-subnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.cidr_prefix}.102.0/24"
  availability_zone = data.aws_availability_zones.az.names[2]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.prefix}-${var.cidr_prefix}-private-subnet2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}-${var.cidr_prefix}-gw"
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = {
    Name = "${var.prefix}-${var.cidr_prefix}-default" 
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}-${var.cidr_prefix}-private"
  }
}

resource "aws_route_table_association" "private-subnet0" {
  subnet_id      = aws_subnet.private-subnet0.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-subnet1" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-subnet2" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.private.id
}
