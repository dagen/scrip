pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'scp -r . ubuntu@www.dagen.net:/var/www/temp_deploy/scrip/'
            }
        }
    }
}
