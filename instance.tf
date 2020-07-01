resource "aws_key_pair" "hoangviet88vn" {
    key_name                    = "hoangviet88vn"
    public_key                  = "${file("${var.key_path}/id_rsa.pub")}"
}
resource "aws_instance" "wintest01" {
    ami                         = "${lookup(var.amis , var.aws_region )}"
    instance_type               = "t2.micro"
    availability_zone           = "ap-southeast-1a"
    associate_public_ip_address = true
    subnet_id                   = "${aws_subnet.mysubnet01.id}"
    vpc_security_group_ids      = ["${aws_security_group.mysg01.id}"]
    get_password_data           = true
    key_name                    = "${aws_key_pair.hoangviet88vn.key_name}"
    root_block_device {
        volume_type             = "gp2"
        volume_size             = "30"
        delete_on_termination   = true
    }
}