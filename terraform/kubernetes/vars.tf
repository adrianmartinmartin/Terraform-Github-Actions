variable "instance_type" {
  type = string
  default = "t3.medium"
  description = "El tipo de instancia"
} 

variable "prefix" {
  type = string
  default = "agp"
}

variable "region" {
  type = string
  default = "us-east-1"
}
