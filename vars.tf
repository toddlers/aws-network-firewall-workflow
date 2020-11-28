variable "firewall-name" {
  type    = string
  default = "test-aws-network-firewall"
}

variable "vpc-name" {
  type    = string
  default = "test-network-firewall"
}
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "dhcp_domain" {
  type    = string
  default = "eu-central-1.compute.internal"
}
variable "http-domains-to-deny" {
  type    = list
  default = ["test.example.com"]
}
variable "https-domains-to-deny" {
  type    = list
  default = ["test.example.com"]
}

variable "ssh-key-full-path" {
  type    = string
  default = "/Users/username/.ssh/id_rsa.pub"

}

variable "cloudwatch-log-group-name" {
  type    = string
  default = "test-aws-network-firewall"
}

variable "ami-id" {
  type = string
  default = "ami-04d29b6f966df1537"
}

variable "instance-type" {
  type = string
  default = "t2.micro"
}