resource "aws_instance" "demolocalstack" {
    ami           = "ami-0e2ff28bfb72a4e45"
    instance_type = "t2.micro"
    tags = {
        Name = "educacionit"
    }
}