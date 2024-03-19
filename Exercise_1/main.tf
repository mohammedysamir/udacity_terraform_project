# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  region = "us-east-1"
  access_key = "AKIAQSGIY62VMMP72672"
  secret_key = "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"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2

resource "aws_instance" "Udacity_T2" {
    count = 4
    ami = "ami-02d7fd1c2af6eead0"
    instance_type = "t2.micro"
    subnet_id = "subnet-07da43518aebb8caa"
    tags = {
      "Name" = "Udacity T2 EC2 instaces" 
    }
}
# TODO: provision 2 m4.large EC2 instances named Udacity M4

resource "aws_instance" "Udacity_M4" {
    count = 2
    subnet_id = "subnet-07da43518aebb8caa"
    ami = "ami-032346ab877c418af"
    instance_type = "m4.large"
    tags = {
      "Name" = "Udacity M4 EC2 instaces" 
    }
}