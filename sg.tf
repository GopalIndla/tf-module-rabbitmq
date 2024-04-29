# security groups that allows only ws netwokr and internal network
resource "aws_security_group" "allow_rabbitmq" {
  name                    = "roboshop-${var.ENV}-rabbitmq-sg"
  description             = "roboshop-${var.ENV}-rabbitmq-sg"
  vpc_id                  = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  ingress {
    from_port       = var.RABBIRMQ_PORT
    to_port         = var.RABBIRMQ_PORT
    protocol        = "tcp"
    cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-rabbitmq-sg"
  }
}

