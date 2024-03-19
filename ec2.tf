resource "aws_instance" "meme_service_ec2" {
  ami = "ami-0f3a440bbcff3d043"
  availability_zone = aws_subnet.meme_vpc_private_subnet1.availability_zone
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraform-key-pair.key_name
  vpc_security_group_ids = [
    aws_default_security_group.meme_vpc_default.id,
  ]
  subnet_id = aws_subnet.meme_vpc_public_subnet1.id
  associate_public_ip_address = true

  tags = {
    Name = "meme_service_ec2"
  }
}

resource "aws_instance" "meme_auth_ec2" {
  ami = "ami-0f3a440bbcff3d043"
  availability_zone = aws_subnet.meme_vpc_private_subnet2.availability_zone
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraform-key-pair.key_name
  vpc_security_group_ids = [
    aws_default_security_group.meme_vpc_default.id,
  ]
  subnet_id = aws_subnet.meme_vpc_public_subnet2.id
  associate_public_ip_address = true

  tags = {
    Name = "meme_auth_ec2"
  }
}

#resource "aws_instance" "bastion_host" {
#  ami = "ami-0f3a440bbcff3d043"
#  availability_zone = aws_subnet.meme_vpc_public_subnet1.availability_zone
#  instance_type = "t2.micro"
#  key_name = aws_key_pair.terraform-key-pair.key_name
#  vpc_security_group_ids = [
#    aws_default_security_group.meme_vpc_default.id,
#    aws_security_group.meme_vpc_bastion.id
#  ]
#  subnet_id = aws_subnet.meme_vpc_public_subnet2.id
#  associate_public_ip_address = true
#
#  tags = {
#    Name = "meme_auth_ec2"
#  }
#}

resource "aws_eip" "meme_auth_ec2" {
  instance = aws_instance.meme_auth_ec2.id
  depends_on = ["aws_internet_gateway.meme_vpc_igw"]
}

resource "aws_eip" "meme_service_ec2" {
  instance = aws_instance.meme_service_ec2.id
  depends_on = ["aws_internet_gateway.meme_vpc_igw"]
}

