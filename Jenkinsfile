pipeline {
    agent any
    parameters {
        string(name: "version", defaultValue: "v1.0.1", trim: true, description: "Введите версию")
    }
    stages {
        stage('Checkout') { // добавим новый Stage
            steps {
                git branch: 'main', url: "https://github.com/nickwokeupinseoul/devops_work.git" // используем встроенный в Jenkins плагин Git для скачивания проекта из бранча main
            }
        }
        stage('terraform init') {
            steps {
                dir('/opt/devops_work/terraform') {  
                    sh 'terraform init'
                }
            }
        }
        stage('terraform apply') {
            steps {
                dir('/opt/devops_work/terraform') {  
                    sh 'terraform apply -auto-approve'
                }
            }
        }    

        stage('Make /etc/ansible/hosts for ansible') {
            steps {
                sh """
                    echo '[serv-sbor]' > /etc/ansible/hosts
                    terraform output -raw external_ip_address_sborka >> /etc/ansible/hosts
                    echo ' ansible_user=user ansible_ssh_private_key_file=/var/lib/jenkins/id_rsa' >> /etc/ansible/hosts
                    echo '\n[serv-prod]' >> /etc/ansible/hosts
                    terraform output -raw  external_ip_address_prod >> /etc/ansible/hosts
                    echo ' ansible_user=user ansible_ssh_private_key_file=/var/lib/jenkins/id_rsa' >> /etc/ansible/hosts
                    echo '\n' >> /etc/ansible/hosts
                """
            }        
        }   
        
        stage('Make variables for registry in ansible') {
            steps {
                sh """
                    echo -n '---\nregistry_id: ' > /etc/ansible/variables.yml
                    terraform output -raw yandex_container_registry_id >> /etc/ansible/variables.yml
                    echo -n '\nversion: ' >> /etc/ansible/variables.yml
                    echo \"$version\" >> /etc/ansible/variables.yml
                """
            }
        }

        stage('Run playbook') {
            steps {
                sh 'sudo -n ansible-playbook playbook.yml'
            }
        }      
    }
}
