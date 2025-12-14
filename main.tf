provider "aws" { 
    region = "eu-west-3"
}
resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_blocks 
  tags = {
    Name: "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source = "./modules/subnet"
  subnet_cidr_blocks = var.subnet_cidr_blocks
  avail_zone = var.env_prefix
  vpc_id = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
  env_prefix = var.env_prefix

}

module "myapp-webserver" {
  source = "./modules/webserver"
  my_ip = var.my_ip
  env_prefix = var.env_prefix
  image_name = var.image_name
  avail_zone = var.env_prefix
  vpc_id = aws_vpc.myapp-vpc.id
  instance_type = var.instance_type
  public_key_location = var.public_key_location
  subnet_id = module.myapp-subnet.subnet.id

}













