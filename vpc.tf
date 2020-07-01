resource "aws_vpc" "myvpc01" {
    cidr_block                  =  "10.10.0.0/16"
    enable_dns_hostnames        =  true
    enable_dns_support          =  true
    tags                        =  {
    name                        =  "myvpc01"
    }
}
resource "aws_subnet" "mysubnet01" {
    vpc_id                      =  "${aws_vpc.myvpc01.id}"
    availability_zone           =  "ap-southeast-1a"
    cidr_block                  =  "10.10.10.0/24"
    map_public_ip_on_launch     =  true
    tags                        =  {
    name                        =  "Public Subnet"
    }
}
resource "aws_subnet"  "mysubnet02" {
    vpc_id                      =  "${aws_vpc.myvpc01.id}"
    availability_zone           =  "ap-southeast-1a"
    cidr_block                  =  "10.10.20.0/24"
    map_public_ip_on_launch     =  false
    tags                        =  {
    name                        =  "Private Subnet"
    }
}
resource "aws_internet_gateway" "mygw01" {
    vpc_id                      = "${aws_vpc.myvpc01.id}"
    tags                        = {
    name                        = "mygw01"
    }
}
resource "aws_route_table" "myroute01" {
    vpc_id                      = "${aws_vpc.myvpc01.id}"
    route {
    cidr_block                  = "0.0.0.0/0"
    gateway_id                  = "${aws_internet_gateway.mygw01.id}"
    }
    tags                        = {
    name                        = "myroute01"
    }
}
resource "aws_route_table_association" "mysubnet_route01" {
    subnet_id                   = "${aws_subnet.mysubnet01.id}"
    route_table_id              = "${aws_route_table.myroute01.id}"
}
resource "aws_security_group" "mysg01" {
    name                        = "MYSG01"
    description                 = "Allow WINRM AND RDP PORT"
    vpc_id                      = "${aws_vpc.myvpc01.id}"
    ingress {
        description             = "Allow WINRM PORT"
        from_port               = "5985"
        to_port                 = "5985"
        protocol                = "tcp"
        cidr_blocks             = ["0.0.0.0/0"]
    }
    ingress {
        description             = "Allow RDP"
        from_port               = "3389"
        to_port                 = "3389"
        protocol                = "tcp"
        cidr_blocks             = ["0.0.0.0/0"]
    }
    egress  {
        description             = "Allow All Outgoing Traffic To Internet"
        from_port               = 0
        to_port                 = 0
        protocol                = "-1"
        cidr_blocks             = ["0.0.0.0/0"]
    }
}


