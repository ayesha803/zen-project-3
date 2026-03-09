pipeline {
    agent any

    environment {
        DEV_REPO = "ayeshadockerhub/react-dev-repo"
        PROD_REPO = "ayeshadockerhub/react-prod-repo"
        APP_SERVER = "100.31.149.105"
    }

    stages {

        stage('Debug') {
    steps {
        echo "The current branch is: ${env.GIT_BRANCH}"
    }
}

        stage('Build Image') {
            steps {
                sh 'chmod +x build.sh'
                sh './build.sh'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push to Dev Repo') {
            when { 
                expression { env.GIT_BRANCH == 'origin/dev' } 
            }
            steps {
                sh '''
                docker tag app-image:latest $DEV_REPO:latest
                docker push $DEV_REPO:latest
                '''
            }
        }

        stage('Push to Prod Repo') {
            when { 
                expression { env.GIT_BRANCH == 'origin/main' } 
            }
            steps {
                sh '''
                docker tag app-image:latest $PROD_REPO:latest
                docker push $PROD_REPO:latest
                '''
            }
        }

        stage('Deploy to App Server') {
           when { 
                expression { env.GIT_BRANCH == 'origin/main' } 
            }
            steps {
                withCredentials([usernamePassword(
            credentialsId: 'dockerhub-creds',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS'
        )]) {
                sshagent(['ec2-ssh-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@$APP_SERVER '
                    export DOCKER_USER=$DOCKER_USER
                    export DOCKER_PASS=$DOCKER_PASS
                    git clone https://github.com/ayesha803/zen-project-3.git
                    cd /home/ubuntu/zen-project-3 &&
                    chmod +x deploy.sh &&
                    ./deploy.sh
                    '
                    '''
                }
            }
            }
        }

    }
}
