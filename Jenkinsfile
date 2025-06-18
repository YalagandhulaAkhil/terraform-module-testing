pipeline {
  agent any

  parameters {
    choice(
      name: 'ACTION',
      choices: ['apply', 'destroy'],
      description: 'Choose whether to apply or destroy the infrastructure'
    )
  }

  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
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
            bat "terraform show -no-color tfplan > tfplan.txt"
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
              error "Invalid
