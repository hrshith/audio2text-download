# main.tf

# Declare Docker provider
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Define Docker container resource
resource "docker_image" "audio2txtdowload" {
  name = "asharshith/audio2txtdowload:latest"
}

resource "docker_container" "audio2txtdowload" {
  image = docker_image.audio2txtdowload.latest
  name  = "audio2txt"


  ports {
    internal = 5000
    external = 5000
       }
}
