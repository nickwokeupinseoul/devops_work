pipeline {
    agent any
    parameters {
    string(name: "version", defaultValue: "v1.0.1", trim: true, description: "Введите версию")
    }
    stages {
      stage('terraform init') {
        steps {
          sh 'terraform init'
        }
      }
      stage('terraform apply') {
        steps {
          sh 'terraform apply -auto-approve'
        }
      }
      
    }
}
