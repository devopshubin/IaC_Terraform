variable "REGION" {
  default = "us-east-1"
}

variable "Zone1" {
  default = "us-east-1a"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0fc5d935ebf8bc3bc"
    us-east-2 = "ami-057752b3f1d6c4d6c"
  }

}