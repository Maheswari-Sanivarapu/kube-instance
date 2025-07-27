resource "aws_instance" "kube_instance" {
    ami = local.ami_id
    vpc_security_group_ids = [aws_security_group.allow_all_k8s.id]
    instance_type = "t3.micro"
    user_data = file("k8s.sh")
    tags = {
        Name = "${var.project}-${var.environment}-k8s"
    }
}

resource "aws_security_group" "allow_all_k8s" {
    name = "allow all k8s"
    description = "allow all for description k8s"
    ingress{
        from_port = 0
        to_port = 0 
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}