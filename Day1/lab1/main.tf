terraform {	
   required_providers {
	docker = {
		source = "kreuzwerker/docker"
                version = "2.23.0"
	}
   }
}

provider "docker" {}

resource "docker_image" "nginx" {
	name = "bitnami/nginx:latest"
	keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id

  name = "my-nginx-container"

  ports {
	internal = 8080
	external = 9090
  }

}

