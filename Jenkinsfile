pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
    TF_VAR_aws_region = "${AWS_REGION}"
  }

  stages {

    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/your-org/terraform-project.git'
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'terraform --version'
        sh 'aws --version'
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Validate') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -var-file=terraform.tfvars -out=tfplan.out'
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: "Approve Terraform Apply?"
        sh 'terraform apply tfplan.out'
      }
    }

  }

  post {
    always {
      archiveArtifacts artifacts: '**/*.tf', allowEmptyArchive: true
    }
    failure {
      echo 'Terraform apply failed.'
    }
  }
}
