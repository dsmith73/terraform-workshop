
variable "do_token" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "hello_world" {
  image  = "debian-9-x64"
  name   = "hello-world"
  region = "lon1"
  size   = "512mb"

  ssh_keys = [
    "11:f4:d8:2d:c0:6a:a7:73:2d:6e:c4:5e:5c:1c:71:e0"
  ]
}

output "ipv4" { value = "${digitalocean_droplet.hello_world.ipv4_address}" }
