# ASG variables
variable "ami_image" {
  default     = "ami-02e136e904f3da870"
  description = "Uses default Amazon AMI"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Default instance type"
}

variable "desired_capacity" {
  default = 4
}

variable "max_size" {
  default = 5
}
variable "min_size" {
  default = 2
}