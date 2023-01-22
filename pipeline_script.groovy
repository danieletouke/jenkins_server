pipeline {
    agent any

    stages {
        stage('Cloning') {
            steps {
                echo 'Cloning...'

               
               
            }
        }
        stage('Build') {
            steps {
                echo 'BUilding...'

                sh 'docker build -t Dockerfile'

                

            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}