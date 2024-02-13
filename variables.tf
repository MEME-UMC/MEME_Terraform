variable "DB_USERNAME" {
  default = "admin"
}

variable "DB_PASSWORD" {
  default = "admin123"
}

variable "S3_BUCKET_NAME" {
  default = "meme-bucket-terraform"
}

variable "DB_IDENTIFIER" {
  default = "meme-terraform-rds"
}

variable "PUBLIC_KEY" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCRPPeUKzH3f2ppqOfyQcKhca4GB3vpX+o+slAlANoqLMKi85wUy5i3WiHlFp7SLZkVGMfSBP3iqnlro90AL5xJtWmGJpRdmhyNvlnAWcZNt4OF7o0yT6hDrs3kTOkDiVVI5tWV39P9ZbylqLCYlmu431j1wNqcjjiLLkSaI/zccZLQ5bomO1JWXMqt2Lfc/353T1LTXfKV67qhwaSHD5pLxlfMq386kkZSR35zCqpsAqgPLwCbWgCcP5vCipqKuxMsbuW5adbRnOiIcNg0XJi72kUC6m47ItgkZIeegL+ZQNYDtYniEQGdOWa1zT8FSi+xkCYlZziVg/0vyOsARP6HemezyPEwFqb/t5gn5XP4Sd8xonSFlgz/b7MlyCiOM/AE92CrKHNK4TI3qnEFulKDfB8bQ3tfmuU5egwI4b6E+y82qOsD3vc7bwv65LPF1s9nLMybAmN9nRezPPfu8fDWPB6UgxHswIvCpb49SnzYJxF4PTCGuPkpenk4k2O/hZpnpUDGBMM8eftHEqXbfzzX3U1h64yvzidtZcWrMZEBUNQe7VSMisvvOWJ1uO81Z+33zn3HCJt4wrUqaRQBeInEUicOd1Ifc+Xrn0cy8FLLoPUnfI3qr6XajOuVouNv7H6YbSc8YBFQl74tQngYbXhxZsaWbnSw6UzujDKQNGcUQ=="
}

variable "CERTIFICATE_DOMAIN" {
  default = "*.teddytown.shop"
}

variable "DNS" {
  default = "teddytown.shop"
}

variable "GATEWAY_DNS" {
  default = "api.teddytown.shop"
}
