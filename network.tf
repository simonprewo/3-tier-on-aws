resource "aws_vpc" "interview_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "interview_subnet" {
  vpc_id                  = aws_vpc.interview_vpc.id
  cidr_block              = "10.0.0.0/28"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "interview_internet_gateway" {
  vpc_id = aws_vpc.interview_vpc.id
}

resource "aws_route_table" "interview_route_table" {
  vpc_id = aws_vpc.interview_vpc.id
}

resource "aws_route" "interview_route" {
  route_table_id         = aws_route_table.interview_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.interview_internet_gateway.id
}

resource "aws_route_table_association" "interview_route_table_association" {
  subnet_id      = aws_subnet.interview_subnet.id
  route_table_id = aws_route_table.interview_route_table.id
}

resource "aws_security_group" "interview_security_group" {
  name   = "interview_security_group"
  vpc_id = aws_vpc.interview_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_eip" "interview_eip" {
  instance = aws_instance.interview_app_server.id
}