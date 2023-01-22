output "jenkins_pub_ip" {
  value = aws_instance.jenkins-master.public_ip
}
