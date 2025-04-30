variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "bastion_ami" {
  description = "AMI ID for bastion host"
  type        = string
}

variable "private_ami" {
  description = "AMI ID for private server"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
