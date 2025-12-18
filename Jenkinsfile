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

        stage('Install Trivy') {
            steps {
                sh '''
                apt-get update
                apt-get install -y wget gnupg lsb-release

                wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
                echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" > /etc/apt/sources.list.d/trivy.list

                apt-get update
                apt-get install -y trivy
                trivy --version
                '''
            }
        }

        stage('Trivy Scan Terraform') {
            steps {
                sh '''
                trivy config terraform --severity HIGH,CRITICAL --exit-code 1 .
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
