module "vpc" {
  source = "./modules/vpc"

}


module "instances" {
    source = "./modules/ec2"
    instance_type = "t3.micro"
}


module "rds" {
  source  = "terraform-aws-modules/rds/aws//modules/db_instance"
  version = "5.2.3"
  # RDS module arguments
  identifier        = "schufards"
  db_name           = "mydb"
  username          = "myusername"
  password          = "mypassword"
  instance_class    = "db.t2.micro"
  engine            = "postgres"
}