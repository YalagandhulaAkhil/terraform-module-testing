pipeline {
  agent any

  parameters {
    choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select Terraform action to perform')
  }

  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    AWS_DEFAULT_REGION    = 'us-east-1'
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
              error "terraform.tfvars file is missing in the main directory!"
            }
          }
        }
      }
    }

    stage('Terraform Init') {
      steps {
        dir('main') {
          withCredentials([
            string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
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
            string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
          ]) {
            bat "terraform plan -out=tfplan -var-file=terraform.tfvars"
          }
        }
      }
    }

    stage('Terraform Apply / Destroy') {
      steps {
        dir('main') {
          script {
            if (params.ACTION == 'apply') {
              bat "terraform apply -auto-approve tfplan"
            } else if (params.ACTION == 'destroy') {
              bat "terraform destroy -auto-approve -var-file=terraform.tfvars"
            } else {
              error("Invalid ACTION selected.")
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
            archiveArtifacts artifacts: '**/*.tf', allowEmptyArchive: true
          }
        }
      }
    }
    failure {
      echo 'Terraform pipeline failed!'
    }
  }
}
