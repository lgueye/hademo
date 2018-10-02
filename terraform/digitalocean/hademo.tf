# droplets specs
variable "droplet_image" {
  default = "ubuntu-18-04-x64"
}
variable "droplet_region" {
  default = "fra1"
}
variable "droplet_size" {
  default = "1gb"
}

# target environment
resource "digitalocean_tag" "target_env" {
  name = "${var.target_env}"
}

# ansible vars
variable "ansible_python_interpreter" {
  default = "/usr/bin/python3"
}

# consul cluster vars
variable "consul_product_name" {
  default = "consul"
}
variable "consul_client_role" {
  default = "consul_client"
}
variable "consul_server_role" {
  default = "consul_server"
}
variable "consul_ui_role" {
  default = "consul_ui"
}
resource "digitalocean_tag" "consul_product_name" {
  name = "${var.consul_product_name}"
}
resource "digitalocean_tag" "consul_ui_role" {
  name = "${var.consul_ui_role}"
}
resource "digitalocean_tag" "consul_client_role" {
  name = "${var.consul_client_role}"
}
resource "digitalocean_tag" "consul_server_role" {
  name = "${var.consul_server_role}"
}

# consumer service cluster vars
variable "service_name" {
  default = "hademo"
}
resource "digitalocean_tag" "service_name" {
  name = "${var.service_name}"
}

# cockroachdb cluster vars
variable "cockroachdb_product_name" {
  default = "cockroachdb"
}
variable "cockroachdb_client_role" {
  default = "cockroachdb_client"
}
variable "cockroachdb_server_role" {
  default = "cockroachdb_server"
}
resource "digitalocean_tag" "cockroachdb_product_name" {
  name = "${var.cockroachdb_product_name}"
}
resource "digitalocean_tag" "cockroachdb_client_role" {
  name = "${var.cockroachdb_client_role}"
}
resource "digitalocean_tag" "cockroachdb_server_role" {
  name = "${var.cockroachdb_server_role}"
}

# consul droplets and ansible inventory
resource "digitalocean_droplet" "consul_ui_droplet" {
  image = "${var.droplet_image}"
  name = "${var.consul_product_name}-${var.consul_ui_role}"
  region = "${var.droplet_region}"
  size = "${var.droplet_size}"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.consul_product_name.name}","${digitalocean_tag.consul_client_role.name}","${digitalocean_tag.consul_ui_role.name}"]
}
resource "ansible_host" "consul_ui_droplet" {
    inventory_hostname = "${digitalocean_droplet.consul_ui_droplet.name}"
    groups = ["${var.target_env}","${var.consul_product_name}","${var.consul_client_role}","${var.consul_ui_role}"]
    vars {
      ansible_host = "${digitalocean_droplet.consul_ui_droplet.ipv4_address}"
      ansible_python_interpreter = "${var.ansible_python_interpreter}"
    }
}
resource "digitalocean_droplet" "consul_server_01_droplet" {
  image = "${var.droplet_image}"
  name = "${var.consul_product_name}-${var.consul_server_role}-01"
  region = "${var.droplet_region}"
  size = "${var.droplet_size}"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.consul_product_name.name}","${digitalocean_tag.consul_server_role.name}"]
}
resource "ansible_host" "consul_server_01_droplet" {
    inventory_hostname = "${digitalocean_droplet.consul_server_01_droplet.name}"
    groups = ["${var.target_env}","${var.consul_product_name}","${var.consul_server_role}"]
    vars {
      ansible_host = "${digitalocean_droplet.consul_server_01_droplet.ipv4_address}"
      ansible_python_interpreter = "${var.ansible_python_interpreter}"
    }
}
resource "digitalocean_droplet" "consul_server_02_droplet" {
  image = "${var.droplet_image}"
  name = "${var.consul_product_name}-${var.consul_server_role}-02"
  region = "${var.droplet_region}"
  size = "${var.droplet_size}"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.consul_product_name.name}","${digitalocean_tag.consul_server_role.name}"]
}
resource "ansible_host" "consul_server_02_droplet" {
    inventory_hostname = "${digitalocean_droplet.consul_server_02_droplet.name}"
    groups = ["${var.target_env}","${var.consul_product_name}","${var.consul_server_role}"]
    vars {
      ansible_host = "${digitalocean_droplet.consul_server_02_droplet.ipv4_address}"
      ansible_python_interpreter = "${var.ansible_python_interpreter}"
    }
}
resource "digitalocean_droplet" "consul_server_03_droplet" {
  image = "${var.droplet_image}"
  name = "${var.consul_product_name}-${var.consul_server_role}-03"
  region = "${var.droplet_region}"
  size = "${var.droplet_size}"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.consul_product_name.name}","${digitalocean_tag.consul_server_role.name}"]
}
resource "ansible_host" "consul_server_03_droplet" {
    inventory_hostname = "${digitalocean_droplet.consul_server_03_droplet.name}"
    groups = ["${var.target_env}","${var.consul_product_name}","${var.consul_server_role}"]
    vars {
      ansible_host = "${digitalocean_droplet.consul_server_03_droplet.ipv4_address}"
      ansible_python_interpreter = "${var.ansible_python_interpreter}"
    }
}

# service droplets and ansible inventory
resource "digitalocean_droplet" "service_01_droplet" {
  image = "${var.droplet_image}"
  name = "${var.service_name}-01"
  region = "${var.droplet_region}"
  size = "${var.droplet_size}"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.consul_product_name.name}","${digitalocean_tag.consul_client_role.name}","${digitalocean_tag.service_name.name}"]
}
resource "ansible_host" "service_01_droplet" {
    inventory_hostname = "${digitalocean_droplet.service_01_droplet.name}"
    groups = ["${var.target_env}","${var.consul_product_name}","${var.consul_client_role}","${var.service_name}"]
    vars {
      ansible_host = "${digitalocean_droplet.service_01_droplet.ipv4_address}"
      ansible_python_interpreter = "${var.ansible_python_interpreter}"
    }
}
resource "digitalocean_droplet" "service_02_droplet" {
  image = "${var.droplet_image}"
  name = "${var.service_name}-02"
  region = "${var.droplet_region}"
  size = "${var.droplet_size}"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.consul_product_name.name}","${digitalocean_tag.consul_client_role.name}","${digitalocean_tag.service_name.name}"]
}
resource "ansible_host" "service_02_droplet" {
    inventory_hostname = "${digitalocean_droplet.service_02_droplet.name}"
    groups = ["${var.target_env}","${var.consul_product_name}","${var.consul_client_role}","${var.service_name}"]
    vars {
      ansible_host = "${digitalocean_droplet.service_02_droplet.ipv4_address}"
      ansible_python_interpreter = "${var.ansible_python_interpreter}"
    }
}

# cockroachdb droplets and ansible inventory
resource "digitalocean_droplet" "cockroachdb_server_01_droplet" {
  image = "${var.droplet_image}"
  name = "${var.cockroachdb_product_name}-${var.cockroachdb_server_role}-01"
  region = "${var.droplet_region}"
  size = "${var.droplet_size}"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.cockroachdb_product_name.name}","${digitalocean_tag.consul_client_role.name}","${digitalocean_tag.cockroachdb_server_role.name}"]
}
resource "ansible_host" "cockroachdb_server_01_droplet" {
  inventory_hostname = "${digitalocean_droplet.cockroachdb_server_01_droplet.ipv4_address}"
  groups = ["${var.target_env}","${var.cockroachdb_product_name}","${var.consul_client_role}","${var.cockroachdb_server_role}"]
  vars {
    ansible_host = "${digitalocean_droplet.cockroachdb_server_01_droplet.ipv4_address}"
    ansible_python_interpreter = "${var.ansible_python_interpreter}"
  }
}
resource "digitalocean_droplet" "cockroachdb_server_02_droplet" {
  image = "${var.droplet_image}"
  name = "${var.cockroachdb_product_name}-${var.cockroachdb_server_role}-02"
  region = "${var.droplet_region}"
  size = "${var.droplet_size}"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.cockroachdb_product_name.name}","${digitalocean_tag.consul_client_role.name}","${digitalocean_tag.cockroachdb_server_role.name}"]
}
resource "ansible_host" "cockroachdb_server_02_droplet" {
  inventory_hostname = "${digitalocean_droplet.cockroachdb_server_02_droplet.name}"
  groups = ["${var.target_env}","${var.cockroachdb_product_name}","${var.consul_client_role}","${var.cockroachdb_server_role}"]
  vars {
    ansible_host = "${digitalocean_droplet.cockroachdb_server_02_droplet.ipv4_address}"
    ansible_python_interpreter = "${var.ansible_python_interpreter}"
  }
}
resource "digitalocean_droplet" "cockroachdb_server_03_droplet" {
  image = "${var.droplet_image}"
  name = "${var.cockroachdb_product_name}-${var.cockroachdb_server_role}-03"
  region = "${var.droplet_region}"
  size = "${var.droplet_size}"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags = ["${digitalocean_tag.target_env.name}","${digitalocean_tag.cockroachdb_product_name.name}","${digitalocean_tag.consul_client_role.name}","${digitalocean_tag.cockroachdb_server_role.name}"]
}
resource "ansible_host" "cockroachdb_server_03_droplet" {
  inventory_hostname = "${digitalocean_droplet.cockroachdb_server_03_droplet.name}"
  groups = ["${var.target_env}","${var.cockroachdb_product_name}","${var.consul_client_role}","${var.cockroachdb_server_role}"]
  vars {
    ansible_host = "${digitalocean_droplet.cockroachdb_server_03_droplet.ipv4_address}"
    ansible_python_interpreter = "${var.ansible_python_interpreter}"
  }
}
