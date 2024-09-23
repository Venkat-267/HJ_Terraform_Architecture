output "public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.app[*].public_ip  # Make sure you are using "aws_instance" in your ec2 module
}
