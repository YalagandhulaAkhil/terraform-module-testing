pipeline {
  agent any

  environment {
    TF_VAR_region = 'us-east-1'
  }

  stages {
    stage('Checkout Repo') {
      steps {
        checkout scm
      }
    }

    stage('Validate tfvars File') {
      steps {
        dir('main') {
          script {
            if (!fileExists('terraform.tfvars')) {
              error "terraform.tfvars file not found!"
            }
          }
        }
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

    stage('Terraform Apply / Destroy') {
      when {
        expression { return currentBuild.currentResult == 'SUCCESS' }
      }
      steps {
        dir('main') {
          withCredentials([
            string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
          ]) {
            bat 'terraform apply -input=false tfplan'
          }
        }
      }
    }
  }

  post {
    always {
      dir('main') {
        archiveArtifacts artifacts: 'tfplan.txt', onlyIfSuccessful: true
      }
    }
    failure {
      echo 'Terraform pipeline failed!'
    }
  }
}
