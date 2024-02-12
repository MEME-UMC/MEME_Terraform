resource "aws_instance" "meme_service_ec2" {
  ami = "ami-0f3a440bbcff3d043"
  availability_zone = aws_subnet.side_effect_public_subnet1.availability_zone
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraform-key-pair.key_name
  vpc_security_group_ids = [
    aws_default_security_group.side_effect_default.id,
    aws_security_group.side_effect_bastion.id
  ]
  subnet_id = aws_subnet.side_effect_public_subnet1.id
  associate_public_ip_address = true

  tags = {
    Name = "meme_service_ec2"
  }
}

resource "aws_instance" "meme_auth_ec2" {
  ami = "ami-0f3a440bbcff3d043"
  availability_zone = aws_subnet.side_effect_public_subnet2.availability_zone
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraform-key-pair.key_name
  vpc_security_group_ids = [
    aws_default_security_group.side_effect_default.id,
    aws_security_group.side_effect_bastion.id
  ]
  subnet_id = aws_subnet.side_effect_public_subnet2.id
  associate_public_ip_address = true

  tags = {
    Name = "meme_auth_ec2"
  }
}

resource "aws_eip" "meme_auth_ec2" {
  vpc = true
  instance = aws_instance.meme_auth_ec2.id
  depends_on = ["aws_internet_gateway.side_effect_igw"]
}

resource "aws_eip" "meme_service_ec2" {
  vpc = true
  instance = aws_instance.meme_service_ec2.id
  depends_on = ["aws_internet_gateway.side_effect_igw"]
}

output "elastic-ip-auth" { # rds cluster의 writer 인스턴스 endpoint 추출 (mysql 설정 및 Three-tier 연동파일에 정보 입력 필요해서 추출)
  value = aws_eip.meme_auth_ec2.public_ip
}

output "elastic-ip-service" { # rds cluster의 writer 인스턴스 endpoint 추출 (mysql 설정 및 Three-tier 연동파일에 정보 입력 필요해서 추출)
  value = aws_eip.meme_service_ec2.public_ip
}
