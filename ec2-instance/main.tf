resource "aws_instance" "ec2-server" {
  count = length(var.subnet_id)
  key_name = "terra-key"
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id[count.index]
  vpc_security_group_ids = [ var.security_group_ids[count.index] ]
  user_data = <<-EOL
      #!/bin/bash
      yes|sudo apt update
      yes|sudo apt install apache2
      echo "<h1>Server details</h1><p><strong>Hostname:</strong>$(hostname)</p><p><strong>IP address:</strong>$(hostname -I | cut -d" " -f1)</p>" > /var/www/html/index.html
      sudo systemctl restart apache2
      EOL
  tags = {
    Name = "instance-${count.index + 1}"
  }
}