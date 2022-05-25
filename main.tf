# Creating networking for the project


resource "aws_vpc" "Eng-Achie" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "Eng-Achie"
  }
}


# Public Subnet 1


resource "aws_subnet" "Public_Subnet_1" {
  vpc_id            = aws_vpc.Eng-Achie.id
  cidr_block        = var.public1-cidr
  availability_zone = var.az1


  tags = {
    Name = "Public_Subnet_1"
  }
}


# Public Subnet 2


resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.Eng-Achie.id
  cidr_block        = var.public2-cidr
  availability_zone = var.az2


  tags = {
    Name = "Public_Subnet_2"
  }
}


# Private Subnet 1


resource "aws_subnet" "Private_Subnet_1" {
  vpc_id            = aws_vpc.Eng-Achie.id
  cidr_block        = var.private1-cidr
  availability_zone = var.az1


  tags = {
    Name = "Private_Subnet_1"
  }
}


# Private Subnet 2


resource "aws_subnet" "Private_Subnet_2" {
  vpc_id            = aws_vpc.Eng-Achie.id
  cidr_block        = var.private2-cidr
  availability_zone = var.az2



  tags = {
    Name = "Private_Subnet_2"
  }
}


# Public Route table


resource "aws_route_table" "Achie_Public_Route" {
  vpc_id = aws_vpc.Eng-Achie.id



  tags = {
    Name = "Achie_Public_Route"
  }
}


# Private Route table


resource "aws_route_table" "Achie_Private_Route" {
  vpc_id = aws_vpc.Eng-Achie.id



  tags = {
    Name = "Achie_Private_Route"
  }
}


# Associate public subnets with the public route table


resource "aws_route_table_association" "pub_sub1_route_assoc" {
  subnet_id      = aws_subnet.Public_Subnet_1.id
  route_table_id = aws_route_table.Achie_Public_Route.id
}



resource "aws_route_table_association" "pub_sub2_route_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.Achie_Public_Route.id
}


# Associate private subnets with the private route table


resource "aws_route_table_association" "priv_sub1_route_assoc" {
  subnet_id      = aws_subnet.Private_Subnet_1.id
  route_table_id = aws_route_table.Achie_Private_Route.id
}


resource "aws_route_table_association" "priv_sub2_route_assoc" {
  subnet_id      = aws_subnet.Private_Subnet_2.id
  route_table_id = aws_route_table.Achie_Private_Route.id
}


# Internet Gateway


resource "aws_internet_gateway" "achie_igw" {
  vpc_id = aws_vpc.Eng-Achie.id


  tags = {
    Name = "Achie_IGW"
  }
}


# Associate the internet gateway to the public route table


resource "aws_route" "Achie_IGW_route_assoc" {
  route_table_id         = aws_route_table.Achie_Public_Route.id
  gateway_id             = aws_internet_gateway.achie_igw.id
  destination_cidr_block = "0.0.0.0/0"
}



