pipeline {
    agent none

    stages {

        stage('Checkout') {
            agent any
            steps {
                checkout scm
            }
        }

        stage('Trivy Scan Terraform') {
            agent {
                docker {
                    image 'aquasec/trivy:latest'
                    args '-v $PWD:/project'
                }
            }
            steps {
                sh '''
                trivy config /project/terraform \
                  --severity HIGH,CRITICAL \
                  --exit-code 1
                '''
            }
        }

        stage('Terraform Init & Plan') {
            agent {
                docker {
                    image 'hashicorp/terraform:1.6'
                    args '-v $PWD:/project'
                }
            }
            steps {
                sh '''
                cd /project/terraform
                terraform init
                terraform plan
                '''
            }
        }
    }
}
