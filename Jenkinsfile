pipeline{

agent any
environment {
 DEV_REPO = ayeshadockerhub/react-dev-repo
 PROD_REPO = ayeshadockerhub/react-prod-repo
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
                sh '''
                docker tag react-devops-app $DEV_REPO:latest
                docker push $DEV_REPO:latest
                '''
            }

}

stage('Push Prod Image') {
            when {
                branch 'master'
            }
            steps {
                sh '''
                docker tag react-devops-app $PROD_REPO:latest
                docker push $PROD_REPO:latest
                '''
            }
        }

}

}
