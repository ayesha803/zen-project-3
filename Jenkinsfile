pipeline {
    agent any

    environment {
        DEV_REPO = "dockerhubusername/dev"
        PROD_REPO = "dockerhubusername/prod"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/username/devops-build.git'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t app-image .'
            }
        }

        stage('Push to Dev Repo') {
            when {
                branch 'dev'
            }
            steps {
                sh '''
                docker tag app-image $DEV_REPO:latest
                docker push $DEV_REPO:latest
                '''
            }
        }

        stage('Push to Prod Repo') {
            when {
                branch 'master'
            }
            steps {
                sh '''
                docker tag app-image $PROD_REPO:latest
                docker push $PROD_REPO:latest
                '''
            }
        }

        stage('Deploy') {
            when {
                branch 'master'
            }
            steps {
                sh './deploy.sh'
            }
        }

    }
}
