output "jenkins_pub_ip" {
  value = aws_instance.jenkins-server.private_ip
}

