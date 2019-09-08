terraform {
  required_version = "~> 0.12.1"
}

# DigitalOcean token required
# ---
# provider "digitalocean" {
#   token = "...token..."
# }
#
# ...or...
#
# variable "do_token" {
#   default = "...token..."
# }
#
# provider "digitalocean" {
#   token = var.do_token
# }

module "development_fast" {
  source          = "../../terraform-digitalocean-ethereum-geth"
  name            = "eth-test-fast"
  region          = "ams3"
  trusted_sources = ["0.0.0.0/0", "::/0"]
  ssh_keys        = var.ssh_keys
  volume_size     = 150
  syncmode        = "fast"
  gcmode          = "full"
}

module "development_full" {
  source          = "../../terraform-digitalocean-ethereum-geth"
  name            = "eth-test-full"
  region          = "ams3"
  trusted_sources = ["0.0.0.0/0", "::/0"]
  ssh_keys        = var.ssh_keys
  volume_size     = 600
  syncmode        = "full"
  gcmode          = "archive"
}

module "production_fast" {
  source          = "../../terraform-digitalocean-ethereum-geth"
  name            = "eth-main-fast"
  servers         = 2
  size            = "s-4vcpu-8gb"
  region          = "ams3"
  trusted_sources = ["0.0.0.0/0", "::/0"]
  ssh_keys        = var.ssh_keys
  volume_size     = 400
  testnet         = false
  cache           = 2048
  syncmode        = "fast"
  gcmode          = "full"
}

module "production_full" {
  source          = "../../terraform-digitalocean-ethereum-geth"
  name            = "eth-main-full"
  servers         = 2
  size            = "s-6vcpu-16gb"
  region          = "ams3"
  trusted_sources = ["0.0.0.0/0", "::/0"]
  ssh_keys        = var.ssh_keys
  volume_size     = 500
  testnet         = false
  cache           = 4096
  syncmode        = "full"
  gcmode          = "archive"
}
