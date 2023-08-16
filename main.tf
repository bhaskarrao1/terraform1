

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for EC2 instance"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




resource "aws_instance" "ec2_instance" {
  ami           = "ami-053b0d53c279acc90"  
  instance_type = var.instancetype
  subnet_id     = var.subnet_id
  key_name      = var.my-key

  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  connection {
    type        = "ssh"
    user        = "ubuntu" 
    private_key = var.my-key  
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'Remote command executed successfully!'",
      "sudo apt-get update -y",  
      "sudo apt-get install -y apache2",  
      "sudo systemctl enable apache2", 
      "sudo systemctl start apache2",  
      "sudo systemctl status apache2"  
    ]
  }
}