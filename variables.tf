variable "location" {
  description = "variavel que indica região onde os recursos vão ser criado"
  type        = string
  default     = "East US"
}

variable "aws_pub_key" {
  description = "Public key para vm na aws"
  type = string
  
}

variable "azure_pub_key" {
  description = "Public key para vm na azure"
  type = string
  
}

