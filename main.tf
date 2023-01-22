resource "aws_instance" "jenkins-server" {
  
  root_block_device {
    volume_size = "50"
    volume_type = "gp3"
  }
  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name
  ami           = data.aws_ami.latest-ami2.id
  instance_type = "t2.micro"
  
  tags = {
    Name = "My 2nd Jenkins Server"
  }
  vpc_security_group_ids = [ "sg-07072bbbaea42e6d4" ]
  key_name = "nvkp-dev"

  user_data = <<EOF
      #!/bin/bash

      yum update –y
      wget -O /etc/yum.repos.d/jenkins.repo \
      https://pkg.jenkins.io/redhat-stable/jenkins.repo
      rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
      yum upgrade -y
      yum install aws-cli -y
      yum install terraform -y
      amazon-linux-extras install java-openjdk11 -y
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

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-profile"
  role = "ec2-access-s3"  # The role name can be found in the console for aws managed policies and other pre-created policies
}