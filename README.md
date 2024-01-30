# devops_work
Написать Jenkins pipeline, который разворачивает инстансы в VK cloud, производит на них сборку Java приложения и деплоит приложение на стэйдж. 
Необходимо использовать код Terraform и Ansible. Приложение должно быть развернуто в контейнере.

## Сервер main (terraform, jenkins, ansible) создает две ВМ (serv_sbor, serv-prod) и управляет ими
**Предварительные работы на main**
* sudo apt update
* sudo apt install git -y
* sudo apt install mc -y
