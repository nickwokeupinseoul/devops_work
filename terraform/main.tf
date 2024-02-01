resource "yandex_compute_instance" "sborka" {
  name = "serv-sbor"
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    disk_id = yandex_compute_disk.serv-sbor_ubuntu2004_15GB.id
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  metadata = {
    user-data = "${file("/home/user/devops_work/terraform/metadata.yml")}"
  }
  scheduling_policy {
    preemptible = true
  }

  connection {
    type     = "ssh"
    user     = "user"
    private_key = file("/home/user/.ssh/id_rsa")
    host = yandex_compute_instance.sborka.network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install ansible -y"
    ]
  }
}


resource "yandex_compute_instance" "prod" {
  name = "serv-prod"
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    disk_id = yandex_compute_disk.serv-prod_ubuntu2004_15GB.id
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  metadata = {
    user-data = "${file("/home/user/devops_work/terraform/metadata.yml")}"
  }
  scheduling_policy {
    preemptible = true
  }

  connection {
    type     = "ssh"
    user     = "user"
    private_key = file("/home/user/.ssh/id_rsa")
    host = yandex_compute_instance.prod.network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install ansible -y"
    ]
  }

}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_disk" "serv-sbor_ubuntu2004_15GB" {
  type     = "network-ssd"
  zone     = "ru-central1-a"
  image_id = data.yandex_compute_image.ubuntu_image.id
  size = 15
}

resource "yandex_compute_disk" "serv-prod_ubuntu2004_15GB" {
  type     = "network-ssd"
  zone     = "ru-central1-a"
  image_id = data.yandex_compute_image.ubuntu_image.id
  size = 15
}

output "external_ip_address_vm_assembly" {
  value = yandex_compute_instance.sborka.network_interface.0.nat_ip_address
}
output "external_ip_address_vm_prod" {
  value = yandex_compute_instance.prod.network_interface.0.nat_ip_address
}
