pipeline {

agent any

stages {

stage('Build') {
steps {
sh 'chmod +x build.sh'
sh './build.sh'
}
}

stage('Deploy') {
    steps {
        sshagent(['app-server-creds']) {
            sh 'chmod +x deploy.sh'
            sh './deploy.sh'
        }
    }
}

}

}
