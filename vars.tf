variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region"     {
    default = "ap-southeast-1"
}
variable "amis" {
    type    = "map"
    default = {
        ap-southeast-1 = "ami-08e79d0c6cf29d3f4"
    }
}
variable "key_path" {}

