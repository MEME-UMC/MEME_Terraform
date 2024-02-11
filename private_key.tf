resource "aws_key_pair" "terraform-key-pair" {
  # 등록할 key pair의 name
  key_name   = "tf-key-pair"

  # public_key = "{.pub 파일 내용}"
  public_key = var.PUBLIC_KEY

  tags = {
    description = "terraform key pair import"
  }
}
