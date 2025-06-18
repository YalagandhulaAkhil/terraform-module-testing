pipeline {
  agent any

  environment {
    TF_IN_AUTOMATION = 'true'
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
      environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
      }
      steps {
        dir('main') {
          bat 'terraform init -reconfigure'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir('main') {
          bat 'terraform plan -var-file="terraform.tfvars"'
        }
      }
    }

    stage('Terraform Apply / Destroy') {
      steps {
        input message: "Do you want to apply the changes?"
        dir('main') {
          bat 'terraform apply -auto-approve -var-file="terraform.tfvars"'
        }
      }
    }
  }

  post {
    always {
      dir('main') {
        archiveArtifacts artifacts: '**/*.tfplan', allowEmptyArchive: true
      }
    }
    failure {
      echo 'Terraform pipeline failed!'
    }
    success {
      echo 'Terraform pipeline completed successfully.'
    }
  }
}
