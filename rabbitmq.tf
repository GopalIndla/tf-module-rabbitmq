# Request a spot instance for Rabbitmq
resource "aws_spot_instance_request" "rabbitmq" {
  ami                       = data.aws_ami.ami.id 
  instance_type             = var.RABBITMQ_INSTANCE_TYPE
  subnet_id                 = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS[0]
  vpc_security_group_ids    = [aws_security_group.allow_rabbitmq.id]
  wait_for_fulfillment      = true   # aws waits for 10 mins to provision ( only in case if aws experiences resource limitation  )

  tags = {
    Name = "roboshop-${var.ENV}-rabbitmq"
  }
}

# Once the server is provisioned, I would like run a playbook that should Configure the RabbitMQ Installation 
resource "null_resource"  "app_install" {
    connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = aws_spot_instance_request.rabbitmq.private_ip
  }

  provisioner "remote-exec" {
    inline = [
        "ansible-pull -U https://github.com/b57-clouddevops/ansible.git -e ENV=dev -e COMPONENT=rabbitmq roboshop-pull.yml"
    ]
  }
}