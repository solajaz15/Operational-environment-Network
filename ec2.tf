
data "aws_ami" "my_data_ami" {
  most_recent = true
  owners      = ["amazon"]
}

/*filter {
  name   = "name"
  values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"]
}
/*filter {
  name   = "root-device-type"
  values = ["ebs"]
}
filter {
  name   = "virtualization-type"
  values = ["hvm"]
}*/


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = local.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["174.109.119.105/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_tls"
  }
}




resource "aws_instance" "instance_type_" {
  ami                    = data.aws_ami.my_data_ami.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pub_subnet_1.id
  key_name               = data.aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  
  tags = {
    Name = "instance_type_"
  }
}

