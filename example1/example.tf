provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "example1" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example1.public_ip} > ipaddress.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example1.id}"
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}
