provider "aws" {
  # region = "us-west-2"
  region = "ap-northeast-1"
}

variable "az" {
  type = list(string)
  default = [ "ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d" ]
}

variable "type" {
  type = string
  default = "t3.large"
}

resource "aws_instance" "web" {
  for_each = var.az

  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = var.type

  tags_all = {
    Name = "HelloWorld-${each}"
    Service = each
    Environment = each
  }
}
