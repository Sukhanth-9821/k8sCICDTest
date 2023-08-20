#!/usr/bin/env groovy

pipeline{
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "ap-south-1"
    }
    parameters {
    string(name: 'DEPLOYMENT_YAML_FILE', description: 'Filename for the deployment YAML')
    string(name: 'SERVICE_YAML_FILE', description: 'Filename for the service YAML')
    }
    stages {
        stage ("Terraform Init"){
            steps{
               script{
                   dir("EKSTerraform"){
                   sh "terraform init"
                   }
               }        
            }
        }
        // stage ("Terraform Plan"){
        //     steps{
        //        script{
        //            dir("EKSTerraform"){
        //            sh "terraform plan"
        //            }
        //        }        
        //     }
        // }
        stage('Approval') {
            input {
                message 'Do you want to proceed with the next stage?'
                ok 'Proceed'
                submitter 'sukhanthwhitehat@gmail.com' // Add the email addresses of your approvers here
            }
            steps {
                script{
                   dir("EKSTerraform"){
                   sh "terraform apply --auto-approve"
                   }
               }  
            }
        }
        stage("Deploy to EKS"){
            steps{
                script{
                    sh "aws eks update-kubeconfig --name suki-tf-cluster"
                    sh "kubectl apply -f ${DEPLOYMENT_YAML_FILE}"
                    sh "kubectl apply -f ${SERVICE_YAML_FILE}"
                }
            }
        }
        stage('Delete_Approval') {
            input {
                message 'Do you want to proceed with the next stage?'
                ok 'Proceed'
                submitter 'sukhanthwhitehat@gmail.com' // Add the email addresses of your approvers here
            }
            steps {
                script{
                   dir("EKSTerraform"){
                   sh "terraform detroy --auto-approve"
                   }
               }  
            }
        }
    }

}