pipeline {
  agent any

  parameters {
    booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply without asking?')
    choice(name: 'action', choices: ['apply', 'destroy'], description: 'Terraform action to perform')
  }

  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    AWS_DEFAULT_REGION    = 'us-east-1'
  }

  stages {
    stage('Checkout Repo') {
      steps {
        echo "Repository already checked out via Declarative SCM"
      }
    }

    stage('Terraform Init') {
      steps {
        dir('main') {
          bat 'terraform init'
        }
      }
    }

    stage('Terraform Plan') {
      when {
        expression { params.action == 'apply' }
      }
      steps {
        dir('main') {
          bat 'terraform plan -out=tfplan -var-file=terraform.tfvars'
          bat 'terraform show -no-color tfplan > tfplan.txt'
        }
      }
    }

    stage('Terraform Apply / Destroy') {
      steps {
        script {
          dir('main') {
            if (params.action == 'apply') {
              if (!params.autoApprove) {
                def planText = readFile('tfplan.txt')
                input message: 'Review the Terraform plan before apply?',
                  parameters: [
                    text(name: 'Plan Preview', description: 'Terraform Plan Output', defaultValue: planText)
                  ]
              }
              bat 'terraform apply -input=false tfplan'
            } else if (params.action == 'destroy') {
              bat 'terraform destroy -auto-approve -var-file=terraform.tfvars'
            } else {
              error "Invalid action selected. Please choose 'apply' or 'destroy'."
            }
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
  }
}
