pipeline {
    agent any

    environment {
        TF_IN_AUTOMATION = "true"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Trivy Scan Terraform') {
            steps {
                sh '''
                docker run --rm \
                  -v "$PWD:/project" \
                  aquasec/trivy:latest \
                  config /project/terraform \
                  --severity HIGH,CRITICAL \
                  --exit-code 1
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                cd terraform
                terraform init
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                cd terraform
                terraform plan
                '''
            }
        }
    }
}
