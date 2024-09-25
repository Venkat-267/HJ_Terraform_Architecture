resource "aws_instance" "app" {
  count         = var.instance_count
  ami           = "ami-0522ab6e1ddcc7055"  # Replace with your AMI ID
  instance_type = "t2.micro"
  subnet_id     = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [var.security_group]

  key_name = "demo"

  provisioner "remote-exec" {
    inline = [
      "echo '13.233.17.181  ip-172-31-36-31.ap-south-1.compute.internal' | sudo tee -a /etc/hosts",
      
      # Install Chef Client
      "curl -L https://omnitruck.chef.io/install.sh | sudo bash",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("modules/ec2/demo.pem")
      host        = self.public_ip
    }
  }

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
