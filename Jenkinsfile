pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Choose whether to apply or destroy the Terraform infrastructure'
        )
    }

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir('main') {
                    withCredentials([
                        string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        bat 'terraform init -reconfigure'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('main') {
                    withCredentials([
                        string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        bat 'terraform plan -out=tfplan -var-file=terraform.tfvars'
                        bat 'terraform show -no-color tfplan > tfplan.txt'
                    }
                }
            }
        }

        stage('Terraform Apply or Destroy') {
            steps {
                dir('main') {
                    withCredentials([
                        string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        script {
                            if (params.ACTION == 'apply') {
                                bat 'terraform apply -input=false tfplan'
                            } else if (params.ACTION == 'destroy') {
                                bat 'terraform destroy -auto-approve -var-file=terraform.tfvars'
                            } else {
                                error "Invalid ACTION parameter value: ${params.ACTION}"
                            }
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                node {
                    dir('main') {
                        archiveArtifacts artifacts: 'tfplan.txt', allowEmptyArchive: true
                    }
                }
            }
            echo 'Terraform pipeline completed.'
        }
        failure {
            echo 'Terraform pipeline failed!'
        }
    }
}
