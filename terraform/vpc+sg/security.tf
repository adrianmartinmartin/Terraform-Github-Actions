resource "aws_security_group" "acceso-local" {
  tags = {
    Name = "${var.prefix}-${var.cidr_prefix}-acceso-local"
  }
  name        = "${var.prefix}-${var.cidr_prefix}-acceso-local"
  description = "${var.prefix}-${var.cidr_prefix}-acceso-local"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "${var.ip_local}"
    ]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      "${var.ip_local}"
    ]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      "${var.ip_local}"
    ]
  }

  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    cidr_blocks = [
      "${var.ip_local}"
    ]
  }
}

