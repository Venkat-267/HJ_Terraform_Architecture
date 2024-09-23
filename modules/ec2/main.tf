resource "aws_instance" "app" {
  count         = var.instance_count
  ami           = "ami-08718895af4dfa033"  # Replace with your AMI ID
  instance_type = "t2.micro"
  subnet_id     = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [var.security_group]

  tags = {
    Name = "App-${count.index}"
  }
}

output "ec2_instance_ids" {
  value = aws_instance.app[*].id
}

output "ec2_instance_public_ips" {
  value = aws_instance.app[*].public_ip
}
