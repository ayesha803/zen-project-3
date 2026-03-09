pipeline {
    agent any

    environment {
        DEV_REPO = "ayeshadockerhub/react-dev-repo"
        PROD_REPO = "dockerhubusername/react-prod-repo"
    }

    stages {

        stage('Build Image') {
            steps {
                sh 'chmod +x build.sh'
                sh './build.sh'
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
                branch 'main'
            }
            steps {
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'
            }
        }

    }
}
