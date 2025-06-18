pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
  }

  stages {
    stage('Checkout Repo') {
      steps {
        git credentialsId: 'for-jenkins', url: 'https://github.com/YalagandhulaAkhil/terraform-module-testing.git', branch: 'main'
      }
    }

    stage('Terraform Init') {
      steps {
        dir('main') {
          withCredentials([
            string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
          ]) {
            bat "terraform init -reconfigure"
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
            bat "terraform plan -out=tfplan -var-file=terraform.tfvars"
          }
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        dir('main') {
          withCredentials([
            string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
          ]) {
            bat "terraform apply -auto-approve tfplan"
          }
        }
      }
    }
  }

  post {
    always {
      echo 'Terraform pipeline completed.'
    }
    failure {
      echo 'Terraform pipeline failed!'
    }
  }
}