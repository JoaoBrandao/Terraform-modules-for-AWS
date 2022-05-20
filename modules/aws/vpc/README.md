# VPC module

This module allows you to choose the nr of subnets and you have the choice of a full HA vpc ready for production or a single nat vpc ideal for your dev environments.

#### Example with only Public Subnets
```hcl-terraform
provider "aws" {
  region                          = ""
  version                         = "~> 1.37"
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

terraform {
  backend "s3" {}
}

module "root<NAME>" {
  source = "git::https://github.com/terraform//modules//aws//vpc//default?ref=<VERSION>"
  # source = "<LOCAL_PATH_FOR_DEV>"
  name                                = "${var.vpc_name}"
  cidr                                = "${var.cidr}"
  dhcp_domain_name                    = "${var.dhcp_domain_name}"
  domain_name_servers                 = ["AmazonProvidedDNS"]
  # dhcp_dns_ntp_servers                = ""
  azs                                 = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets                      = ["${var.public_subnets}"]
  # eip                                 = ["${var.eip}"] # only for fixed NATGW EIPs
  map_ip                              = true
  tag_project                         = "${var.tag_project}"
  tag_env                             = "${var.env}"
  tag_lastmodifyby                    = "${data.aws_caller_identity.current.arn}"
  tag_lastmodifydate                  = "${data.aws_caller_identity.current.id}"
}
```
#### Example of a full stack:

*data.tf*
```hcl-terraform
data "aws_caller_identity" "current" {
}
```
*main.tf*
```hcl-terraform
module "vpc_main" {
  source = "<YOUR_REPO_PATH_AND_VERSION>"
  # source = "<LOCAL_PATH_FOR_DEV>"
  region                              = "${var.region}"
  account                             = "${var.account}"
  name                                = "${var.vpc_name}"
  cidr                                = "${var.cidr}"
  dhcp_domain_name                    = "${var.dhcp_domain_name}"
  # dhcp_dns_ntp_servers                = ""
  azs                                 = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets                      = ["${var.public_subnets}"]
  private_subnets                     = ["${var.private_subnets}"]
  db_subnets                         = ["${var.rds_subnets}"]
  app_subnets                         = ["${var.app_subnets}"]
  # eip                                 = ["${var.eip}"] # only for fixed NATGW EIPs
  map_ip                              = true
  tag_project                         = "${var.tag_project}"
  tag_env                             = "${var.env}"
  tag_lastmodifyby                    = "${data.aws_caller_identity.current.arn}"
  tag_lastmodifydate                  = "${data.aws_caller_identity.current.id}"
}
```

The above examples assume you are using hlc files like this:

*backend.hlc*
```hcl-terraform
bucket = ""
key = ""
region = ""
dynamodb_table = ""
role_arn = "" # Use if the state is on a different account.
```
*environment.hlc*
```hcl-terraform
region = "us-west-1"
account = ""
role_arn = ""
name = ""
cidr = "10.10.0.0/16"
dhcp_domain_name = "demo.local"
public_subnets = ["10.10.1.0/24","10.10.2.0/24","10.10.3.0/24"]
private_subnets = ["10.10.11.0/24","10.10.12.0/24","10.10.13.0/24"]
db_subnets = ["10.10.21.0/24","10.10.22.0/24","10.10.23.0/24"]
app_subnets = ["10.10.31.0/24","10.10.32.0/24","10.10.33.0/24"]
rs_subnets = ["10.10.41.0/24","10.10.42.0/24","10.10.43.0/24"]
env = ""
tag_project = ""
tag_costcenter = ""
```

For a VPC with a single NatGW use the code on the corresponding folder, this module should be used on Dev environments.
