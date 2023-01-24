def MY_REGION='eu-west-1'
pipeline {
    agent any

    stages {
        stage('Cloning') {
            steps {
                echo 'Cloning...'
                sh 'source /var/lib/jenkins/1clone_and_pull_remote_repo.sh'   
            }
        }
        stage('Checking') {
            steps {
                echo 'Checking for yaml file...'
                sh 'source /var/lib/jenkins/workspace/terraform_deploy/jenkins_server/2check_for_yaml_file_get_aws_region.sh'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'source /var/lib/jenkins/workspace/terraform_deploy/jenkins_server/3terraform_apply.sh'
            }
        }  
    }
}