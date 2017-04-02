provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source = "./modules/vpc/"

  region = "${var.region}"
  name = "${var.name}"

  vpc_cidr = "${var.vpc_cidr}"

  sn_public_1_cidr = "${var.vpc_sn_public_1_cidr}"
  sn_public_1_az = "${var.vpc_sn_public_1_az}"
  sn_private_1_cidr = "${var.vpc_sn_private_1_cidr}"
  sn_private_1_az = "${var.vpc_sn_private_1_az}"

  sn_public_2_cidr = "${var.vpc_sn_public_2_cidr}"
  sn_public_2_az = "${var.vpc_sn_public_2_az}"
  sn_private_2_cidr = "${var.vpc_sn_private_2_cidr}"
  sn_private_2_az = "${var.vpc_sn_private_2_az}"
}

module "ec2_backend_a" {
  source = "./modules/ec2"

  subnet_id = "${module.vpc.public_subnet_1_id}"
  name = "backend_a"

  key_name = "weclub_ireland"
  instance_type = "t2.micro"

  region = "${var.region}"
  ami_name = "my_nginx"
  environment = "dev"
  ssh_block = ["0.0.0.0/0"]
  vpc_id = "${module.vpc.id}"
}

module "ec2_backend_b" {
  source = "./modules/ec2"

  subnet_id = "${module.vpc.public_subnet_2_id}"
  name = "backend_b"

  key_name = "weclub_ireland"
  instance_type = "t2.micro"

  region = "${var.region}"
  ami_name = "my_nginx"
  environment = "dev"
  ssh_block = ["0.0.0.0/0"]
  vpc_id = "${module.vpc.id}"
}