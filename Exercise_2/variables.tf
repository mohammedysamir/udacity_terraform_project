# TODO: Define the variable for aws_region
variable "aws_region" {
  description = "The AWS region in which the resources will be created."
  type        = string
  default     = "us-east-1"
}