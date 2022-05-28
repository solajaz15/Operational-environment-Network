
locals {
  local = "mandatory_tag"
}

# creating a vpc

resource "aws_vpc" "kojitechs_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "kojitechs_vpc"
  }
}


# creating pub/pri/DB subnet

resource "aws_subnet" "pub_subnet_1" {
  vpc_id     = local.vpc_id
  cidr_block = var.pub_subnet_cidr[0]

  tags = {
    Name = "pub_subnet_1"
  }
}

resource "aws_subnet" "pub_subnet_2" {
  vpc_id     = local.vpc_id
  cidr_block = var.pub_subnet_cidr[1]

  tags = {
    Name = "pub_subnet_2"
  }
}

resource "aws_subnet" "pri_subnet_1" {
  vpc_id     = local.vpc_id
  cidr_block = var.pri_subnet_cidr[0]

  tags = {
    Name = "pri_subnet_1"
  }
}

resource "aws_subnet" "pri_subnet_2" {
  vpc_id     = local.vpc_id
  cidr_block = var.pri_subnet_cidr[1]

  tags = {
    Name = "pri_subnet_2"
  }
}

resource "aws_subnet" "DB_subnet_1" {
  vpc_id     = local.vpc_id
  cidr_block = var.DB_subnet_cidr[0]

  tags = {
    Name = "DB_subnet_1"
  }
}

resource "aws_subnet" "DB_subnet_2" {
  vpc_id     = local.vpc_id
  cidr_block = var.DB_subnet_cidr[1]

  tags = {
    Name = "DB_subnet_2"
  }
}