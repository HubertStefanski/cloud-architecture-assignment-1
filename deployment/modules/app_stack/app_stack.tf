resource "aws_vpc" "assignment-1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"


  tags = { Name : "CC_AS_1-VPC" }
}

// --------------------------- PUBLIC ------------------------------------
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.assignment-1.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = { Name : "CC_AS_1-subnet-public1-us-east-1a" }

}

resource "aws_internet_gateway" "assignment-1-gateway" {
  vpc_id = aws_vpc.assignment-1.id

  tags = {
    Name = "CC_AS_1-igw"
  }
}

resource "aws_route_table" "rtb-public" {
  vpc_id = aws_vpc.assignment-1.id

  route {
    cidr_block = "0.0.0.0/0	"
    gateway_id = aws_internet_gateway.assignment-1-gateway.id
  }

  route {
    cidr_block       = "10.0.0.0/16"
    local_gateway_id = "local"
  }
  tags = {
    Name = "CC_AS_1-rtb-public"
  }
}




// --------------------------- PRIVATE ------------------------------------
#
#resource "aws_nat_gateway" "example" {
#  allocation_id = aws_eip.example.id
#  subnet_id     = aws_subnet.example.id
#
#  tags = {
#    Name = "CC_AS_1-rtb-private1-us-east-1a"
#  }
#
#  # To ensure proper ordering, it is recommended to add an explicit dependency
#  # on the Internet Gateway for the VPC.
#  depends_on = [aws_internet_gateway.example]
#}
#
#resource "aws_route_table" "rtb-private" {
#  vpc_id = aws_vpc.assignment-1.id
#
#  route {
#    cidr_block = "0.0.0.0/0	"
#    gateway_id = aws_internet_gateway
#  }
#
#  tags = {
#    Name = "CC_AS_1-rtb-private1-us-east-1a"
#  }
#}


resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.assignment-1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = { Name : "CC_AS_1-subnet-private1-us-east-1a" }

}