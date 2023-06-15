output "vpc_id" {
   value = "${aws_vpc.vpc.id}"
}

output "public-subnet0-id" {
   value = "${aws_subnet.public-subnet0.id}"
}

output "public-subnet1-id" {
   value = "${aws_subnet.public-subnet1.id}"
}

output "public-subnet2-id" {
   value = "${aws_subnet.public-subnet2.id}"
}

output "private-subnet0-id" {
   value = "${aws_subnet.private-subnet0.id}"
}

output "private-subnet1-id" {
   value = "${aws_subnet.private-subnet1.id}"
}

output "private-subnet2-id" {
   value = "${aws_subnet.private-subnet2.id}"
}

output "sg_acceso_local_id" {
   value = "${aws_security_group.acceso-local.id}"
}

output "sg_default_id" {
   value = "${aws_vpc.vpc.default_security_group_id}"
}

