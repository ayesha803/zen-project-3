pipeline{

agent any
environment {
 DEV_REPO = "ayeshadockerhub/react-dev-repo"
 PROD_REPO = "ayeshadockerhub/react-prod-repo"
 IMAGE     = "react-devops-app"
 SERVER    = "35.170.75.177" 
}

stages {
 
stage ('Build Docker image'){
steps{

sh 'docker build -t react-devops-app .'

}

}

stage ('Push Dev Image'){

when {
                branch 'dev'
            }

            steps {
             withCredentials([usernamePassword(
            credentialsId: 'dockerhub-creds',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS'
        )]) {
                sh '''
                echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                docker tag react-devops-app $DEV_REPO:latest
                docker push $DEV_REPO:latest
                docker logout
                '''
            }
            }

}

stage('Push Prod Image') {
            when {
                branch 'main'
            }
 
            steps {
             withCredentials([usernamePassword(
            credentialsId: 'dockerhub-creds',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS'
        )]) {
                sh '''
                echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                docker tag react-devops-app $PROD_REPO:latest
                docker push $PROD_REPO:latest
                docker logout
                '''
            }
            }
        }


stage('Dev Deploy') {
  when {
                branch 'dev'
            }
    steps {
        sshagent(['app-server-creds']) {
            withCredentials([usernamePassword(
                credentialsId: 'dockerhub-creds',
                usernameVariable: 'DOCKER_USER',
                passwordVariable: 'DOCKER_PASS'
            )]) {
               sh """
ssh -o StrictHostKeyChecking=no ubuntu@$SERVER "
echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
docker pull $DEV_REPO:latest
docker rm -f react-dev-container || true
docker run -d -p 80:80 --name react-dev-container $DEV_REPO:latest
"
"""
            }
        }
    }
}

 stage('Prod Deploy') {
   when {
                branch 'main'
            }
    steps {
        sshagent(['app-server-creds']) {
            withCredentials([usernamePassword(
                credentialsId: 'dockerhub-creds',
                usernameVariable: 'DOCKER_USER',
                passwordVariable: 'DOCKER_PASS'
            )]) {
              sh """
ssh -o StrictHostKeyChecking=no ubuntu@$SERVER "
echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
docker pull $PROD_REPO:latest
docker rm -f react-prod-container || true
docker run -d -p 3000:80 --name react-prod-container $PROD_REPO:latest
"
"""

            }
        }
    }
}
 

}

}
