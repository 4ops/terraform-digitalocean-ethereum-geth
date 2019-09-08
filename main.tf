terraform {
  required_version = "~> 0.12.1"

  required_providers {
    digitalocean = "~> 1.4"
    template     = "~> 2.1"
    null         = "~> 2.1"
  }
}

module "server" {
  source  = "4ops/docker-server/digitalocean"
  version = "1.0.0"

  name                 = var.name
  random_id            = var.random_id
  servers              = var.servers
  domain               = var.domain
  domain_ttl           = var.domain_ttl
  region               = var.region
  ssh_keys             = var.ssh_keys
  tags                 = var.tags
  size                 = var.size
  backups              = var.backups
  ipv6                 = var.ipv6
  private_networking   = var.private_networking
  monitoring           = var.monitoring
  volume_size          = var.volume_size
  trusted_sources      = var.trusted_sources
  provisioner_username = var.provisioner_username
}

locals {
  service_dir = "/srv/ethereum"
}

resource "null_resource" "update_docker_compose_config" {
  count = var.servers

  triggers = {
    server_ip_changed             = module.server.ipv4[count.index]
    docker_compose_config_changed = sha256(data.template_file.docker_compose_config.rendered)
    serial = 1
  }

  connection {
    type    = "ssh"
    timeout = "2m"

    host        = module.server.ipv4[count.index]
    user        = var.provisioner_username
    private_key = module.server.private_key[count.index]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p ${local.service_dir}",
      "sudo chown ${var.provisioner_username}:docker ${local.service_dir}",
      "chmod 0750 ${local.service_dir}",
      "sudo mkdir -p ${local.service_dir}/data",
      "sudo chown ${var.provisioner_username}:docker ${local.service_dir}/data",
      "chmod 0777 ${local.service_dir}/data",
    ]
  }

  provisioner "file" {
    content     = data.template_file.docker_compose_config.rendered
    destination = "${local.service_dir}/docker-compose.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "cd ${local.service_dir}",
      "docker-compose config --quiet",
      "docker-compose pull --quiet",
      "docker-compose up --detach",
    ]
  }
}
