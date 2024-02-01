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
    user-data = "${file("/home/user/terraform/metadata.yml")}"
  }
  scheduling_policy {
    preemptible = true 
  }

  connection {
    type     = "ssh"
    user     = "spring"
    private_key = file("/var/lib/jenkins/id_rsa")
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
    user-data = "${file("/home/user/terraform/metadata.yml")}"
  }
  scheduling_policy {
    preemptible = true 
  }

  connection {
    type     = "ssh"
    user     = "user"
    private_key = file("/var/lib/jenkins/id_rsa")
    host = yandex_compute_instance.prod.network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update", 
      "sudo apt install ansible -y"
    ]
  }

}
