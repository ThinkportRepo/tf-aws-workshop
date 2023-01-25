module "vpc" {
  source = "../vpc"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Project = "Schufa"
    environment= "dev"
  }
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_ssh"
  description = "Allow SSH"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TCP"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Project = "Schufa"
    environment= "dev"
  }
}