pipeline {
    agent any

    stages {
        stage('Cloning') {
            steps {
                echo 'Cloning...'
                sh 'source 1clone_and_pull_remote_repo.sh'   
            }
        }
        stage('Checking') {
            steps {
                echo 'Checking for yaml file...'
                sh 'source 2check_for_yaml_file_get_aws_region.sh'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'source 3terraform_apply.sh'
            }
        }  
    }
}