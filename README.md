# devops_work
Написать Jenkins pipeline, который разворачивает инстансы в Yandex cloud, производит на них сборку Java приложения и деплоит приложение на стэйдж. 
Необходимо использовать код Terraform и Ansible. Приложение должно быть развернуто в контейнере.

## Сервер main (terraform, jenkins, ansible) создает две ВМ (serv_sbor, serv-prod) и управляет ими
**Предварительные работы на main**
* sudo apt update
* sudo apt install git -y
* sudo apt install mc -y

Настройка yandex cloud: 
* sudo curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
* yc init
* yc config list
* Сгенерировать ключ для сервисного аккаунта: \
yc iam key create --service-account-name <sa_name> --output key.json

Установить Terraform:
* https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli?in=terraform%2Faws-get-started \
* создать /.terraformrc и добавить источник провайдера  \
sudo nano ~/.terraformrc
sudo cp ~/.terraformrc /var/lib/jenkins

Установить Ansible:
* sudo apt install ansible -y

Установить Jenkins: 
* https://www.jenkins.io/doc/book/installing/linux/#debianubuntu
* получить пароль от jenkins admin: \
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword \
* для подключения к консоли: http://ip-adress-main:8080
* Создать pipeline с опцией Pipeline script from SCM (Git). Указать Repository URL, ветку и имя Jenkins-файла
* Запустить pipeline

http://ip-serv-prod:8080/hello
  

  
