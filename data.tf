
data "aws_availability_zones" "azs" {
  state = "available"
}

data "aws_key_pair" "keypair" {
  key_name = "dotech_keypair"

}