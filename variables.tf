

# list
# component = 2pub
# 2 private
# 2 DB
#

variable "pub_subnet_cidr" {
  type        = list(any)
  description = "pub subnet cidr"
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "pri_subnet_cidr" {
  type        = list(any)
  description = "pub subnet cidr"
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "DB_subnet_cidr" {
  type        = list(any)
  description = "pub subnet cidr"
  default     = ["10.0.51.0/24", "10.0.53.0/24"]
}