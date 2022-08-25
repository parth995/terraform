terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {
  # none required as its done for localhost
}

resource "null_resource" "dockervol" {
    provisioner "local-exec" {
        command = "mkdir noderedvol/ || true  && sudo chown -R 1000:1000 noderedvol/"
    }
}

resource "docker_image" "nodered_image" {
    name = var.image[terraform.workspace]
}

#whenever new provider or resource is added, perform terr
#terraform init to load new provider or resource

resource "random_string" "random" {
    count = local.container_count
    length = 5
    special = false
    upper = false
}

resource "docker_container" "nodered_container" {
    count = local.container_count
    name = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
    image = docker_image.nodered_image.latest
    ports {
        internal = var.int_port # it's a number not integer
     #   external = lookup(var.ext_port, terraform.workspace)[count.index]
        external = var.ext_port[terraform.workspace][count.index]
    }
    volumes {
        container_path = "/data"
        host_path = "${path.cwd}/noderedvol"
    }
}