#variable "do_token" {}
#variable "pub_key" {}
#variable "pvt_key" {}
#variable "ssh_fingerprint" {}
variable "target_env" {}

provider "exoscale" {
  key = "${var.exoscale_api_key}"
  secret = "${var.exoscale_secret_key}"
}
