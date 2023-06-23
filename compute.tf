resource "aws_instance" "interview_app_server" {
  ami                    = "ami-04e4606740c9c9381"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.interview_security_group.id]
  subnet_id              = aws_subnet.interview_subnet.id
  user_data              = file("initserver.tpl")
  key_name               = aws_key_pair.interview_key_pair.id
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("key")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "application"
    destination = "/home/ec2-user/application"
  }
}

resource "aws_key_pair" "interview_key_pair" {
  key_name   = "interview_key_pair"
  public_key = file("key.pub")
}