
locals {
  local = "mandatory_tag"
}

# creating a vpc

resource "aws_vpc" "kojitechs_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "kojitechs_vpc"
  }
}
# creating internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "kojitechs_igw"
  }
}

# creating pub/pri/DB subnet

resource "aws_subnet" "pub_subnet_1" {
  vpc_id            = local.vpc_id
  cidr_block        = var.pub_subnet_cidr[0]
  availability_zone = local.azs[0]
  #for az use data source to populate the value
  map_public_ip_on_launch = true
  tags = {
    Name = "pub_subnet_1"
  }
}

resource "aws_subnet" "pub_subnet_2" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.pub_subnet_cidr[1]
  availability_zone       = local.azs[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_subnet_2"
  }
}

resource "aws_subnet" "pri_subnet_1" {
  vpc_id            = local.vpc_id
  cidr_block        = var.pri_subnet_cidr[0]
  availability_zone = local.azs[0]

  tags = {
    Name = "pri_subnet_${local.azs[0]}"
  }
}

resource "aws_subnet" "pri_subnet_2" {
  vpc_id            = local.vpc_id
  cidr_block        = var.pri_subnet_cidr[1]
  availability_zone = local.azs[1]

  tags = {
    Name = "pri_subnet_${local.azs[1]}"
  }
}

resource "aws_subnet" "DB_subnet_1" {
  vpc_id            = local.vpc_id
  cidr_block        = var.DB_subnet_cidr[0]
  availability_zone = local.azs[0]

  tags = {
    Name = "DB_subnet_${local.azs[0]}"
  }
}

resource "aws_subnet" "DB_subnet_2" {
  vpc_id            = local.vpc_id
  cidr_block        = var.DB_subnet_cidr[1]
  availability_zone = local.azs[1]

  tags = {
    Name = "DB_subnet_${local.azs[1]}"
  }
}

#creating a public route table {a use route table is to associate subnet} 

resource "aws_route_table" "route_table" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route_table"
  }
}

# creating route table association for the public subnets

resource "aws_route_table_association" "pub_subnet_1" {
  subnet_id      = aws_subnet.pub_subnet_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "pub_subnet_2" {
  subnet_id      = aws_subnet.pub_subnet_2.id
  route_table_id = aws_route_table.route_table.id
}



# creating a default route table

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.kojitechs_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id #NAT GATEWAY
  }

  tags = {
    Name = "default_route_table"
  }
}

#creating Nat Gateway

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pri_subnet_1.id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.igw]
}


#creating EIP

resource "aws_eip" "eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

}

