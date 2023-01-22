resource "aws_instance" "jenkins-server" {
  
  root_block_device {
    volume_size = "50"
    volume_type = "gp3"
  }
  iam_instance_profile = aws_iam_instance_profile.jenkins_profile2.role
  ami           = data.aws_ami.latest-ami2.id
  instance_type = "t2.micro"
  
  tags = {
    Name = "My 2nd Jenkins Server"
  }
  vpc_security_group_ids = [ aws_security_group.jenkins_sg.id ]

  user_data = <<EOF
      #!/bin/bash

      yum update –y
      wget -O /etc/yum.repos.d/jenkins.repo \
      https://pkg.jenkins.io/redhat-stable/jenkins.repo
      amazon-linux-extras install java-openjdk11 -y
      rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
      yum upgrade -y
      yum install aws-cli -y

      wget https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_linux_amd64.zip
      unzip terraform_1.3.7_linux_amd64.zip
      mv terraform /usr/local/bin
      yum install terraform -y
      yum install jenkins -y
      systemctl enable --now jenkins
      yum install docker -y
      systemctl enable --now docker
      yum install git -y
      wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
      chmod +x /usr/bin/yq


      EOF
}

/* resource "aws_iam_role" "s3_full_access_role" {
  name                = "s3-full-access-role"
  assume_role_policy  = jsonencode()
} */

resource "aws_iam_instance_profile" "jenkins_profile2" {
  name = "jenkins-profile2"
  role = "ec2-access-s3"  # The role name can be found in the console for aws managed policies and other pre-created policies
}

resource "aws_security_group" "jenkins_sg" {
  name = "jenkins-security-group"
}
# creating rules for my jenkins_sg security group
resource "aws_security_group_rule" "allow_ssh_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.jenkins_sg.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_jenkins_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.jenkins_sg.id
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_jenkins_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.jenkins_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
