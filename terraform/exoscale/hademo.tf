variable "product_name" {
  default = "consul"
}
variable "client_role" {
  default = "client"
}
variable "server_role" {
  default = "server"
}
variable "bootstrap_role" {
  default = "bootstrap"
}

#resource "digitalocean_tag" "product_name" {
#  display_name = "${var.product_name}"
#}
#resource "digitalocean_tag" "target_env" {
#  display_name = "${var.target_env}"
#}
#
#resource "digitalocean_tag" "client_role" {
#  display_name = "${var.client_role}"
#}
#
#resource "digitalocean_tag" "server_role" {
#  display_name = "${var.server_role}"
#}
#
#resource "digitalocean_tag" "bootstrap_role" {
#  display_name = "${var.bootstrap_role}"
#}

resource "exoscale_compute" "client_droplet" {
  template = "Linux Ubuntu 18.04 LTS 64-bit"
  display_name = "${var.product_name}-${var.client_role}-terraform"
  zone = "ch-dk-2"
  size = "Micro"
  disk_size = 10
  key_pair = "${var.exoscale_default_ssh_key_pair}"
  #tags = ["${digitalocean_tag.client_role.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.target_env.name}"]
}

resource "ansible_host" "client_droplet" {
    inventory_hostname = "${exoscale_compute.client_droplet.ip_address}"
    groups = ["${var.client_role}","${var.product_name}","${var.target_env}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
    }
}


resource "exoscale_compute" "server_01_droplet" {
  template = "Linux Ubuntu 18.04 LTS 64-bit"
  display_name = "${var.product_name}-${var.server_role}-01-terraform"
  zone = "ch-dk-2"
  size = "Micro"
  disk_size = 10
  key_pair = "${var.exoscale_default_ssh_key_pair}"
  #tags = ["${digitalocean_tag.bootstrap_role.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.target_env.name}"]
}

resource "ansible_host" "server_01_droplet" {
    inventory_hostname = "${exoscale_compute.server_01_droplet.ip_address}"
    groups = ["${var.server_role}","${var.bootstrap_role}","${var.product_name}","${var.target_env}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
#      consul_node_role = "${var.bootstrap_role}"
    }
}

resource "exoscale_compute" "server_02_droplet" {
  template = "Linux Ubuntu 18.04 LTS 64-bit"
  display_name = "${var.product_name}-${var.server_role}-02-terraform"
  zone = "ch-dk-2"
  size = "Micro"
  disk_size = 10
  key_pair = "${var.exoscale_default_ssh_key_pair}"
  #tags = ["${digitalocean_tag.server_role.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.target_env.name}"]
}

resource "ansible_host" "server_02_droplet" {
    inventory_hostname = "${exoscale_compute.server_02_droplet.ip_address}"
    groups = ["${var.server_role}","${var.product_name}","${var.target_env}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
#      consul_node_role = "${var.server_role}"
    }
}

resource "exoscale_compute" "server_03_droplet" {
  template = "Linux Ubuntu 18.04 LTS 64-bit"
  display_name = "${var.product_name}-${var.server_role}-03-terraform"
  zone = "ch-dk-2"
  size = "Micro"
  disk_size = 10
  key_pair = "${var.exoscale_default_ssh_key_pair}"
  #tags = ["${digitalocean_tag.server_role.name}","${digitalocean_tag.product_name.name}","${digitalocean_tag.target_env.name}"]
}

resource "ansible_host" "server_03_droplet" {
    inventory_hostname = "${exoscale_compute.server_03_droplet.ip_address}"
    groups = ["${var.server_role}","${var.product_name}","${var.target_env}"]
    vars {
      ansible_python_interpreter = "/usr/bin/python3"
#      consul_node_role = "${var.server_role}"
    }
}
