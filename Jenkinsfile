pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Trivy Scan Terraform') {
            steps {
                sh '''
                docker run --rm -v $PWD:/project aquasec/trivy:latest \
                config /project/terraform --severity HIGH,CRITICAL --exit-code 1
                '''
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                sh '''
                docker run --rm -v $PWD:/project -w /project/terraform \
                hashicorp/terraform:1.6 init

                docker run --rm -v $PWD:/project -w /project/terraform \
                hashicorp/terraform:1.6 plan
                '''
            }
        }
    }
}
