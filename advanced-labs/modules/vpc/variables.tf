variable "region" {
  description = "Region"
  default     = "eu-central-1"
}

variable "availability_zones" {
  description = "The availability zone where the instance should be started"
  default     = ["eu-central-1a","eu-central-1b"]
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "schufa-vpc"
}

variable "vpc_cidr_block" {
  description = "The CIDR Block for the VPC"
  default     = "172.16.0.0/16"
  #First IP   : 172.16.0.0
  #Last IP    : 172.16.255.255
  #Total Hosts: 65,536
}

variable "public_subnets_cidr_range" {
  description = "The range for the public subnets CIDR blocks for the directory service"
  default     = "172.16.1.0/24"
  #First IP   : 172.16.1.0
  #Last IP    : 172.16.1.255
  #Total Hosts: 256
}
variable "public_subnet_cidr_block_size" {
  description = "Regulates the size of a single public CIDR subnet (in number of bits added to the CIDR prefix)"
  default     = 3
  #With subnet range    : 172.16.1.0/24
  #Max number of subnets: 8
  #Hosts per subnet     : 28 (+4 AWS reserved adresses)
}