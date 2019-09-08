# Cloud resources configuration

variable "name" {
  type = string

  default = "geth"

  description = <<-DESCRIPTION
    Name of service.
    Used as name prefix when generating hostnames.
  DESCRIPTION
}

variable "servers" {
  type = number

  default = 1

  description = <<-DESCRIPTION
    Count of servers to create.
  DESCRIPTION
}

variable "random_id" {
  type = bool

  default = true

  description = <<-DESCRIPTION
    Appends random id to droplet's name if `true`.
  DESCRIPTION
}

variable "domain" {
  type = string

  default = ""

  description = <<-DESCRIPTION
    Domain name.
    Host will be registered in this domain if non-empty value assigned.
  DESCRIPTION
}

variable "domain_ttl" {
  type = number

  default = 300

  description = <<-DESCRIPTION
    TTL in seconds for domain records.
  DESCRIPTION
}

variable "region" {
  type = string

  description = <<-DESCRIPTION
    Required.
    DigitalOcean region for droplet creation.
  DESCRIPTION
}

variable "ssh_keys" {
  type = list

  default = []

  description = <<-DESCRIPTION
    List of SSH keys registered in DigitalOcean.
    User `root` authorized with this keys.
  DESCRIPTION
}

variable "tags" {
  type = list

  default = []

  description = <<-DESCRIPTION
    List of existing tags for droplet.
  DESCRIPTION
}

variable "size" {
  type = string

  default = "s-2vcpu-4gb"

  description = <<-DESCRIPTION
    Size of droplet.
  DESCRIPTION
}

variable "backups" {
  type = bool

  default = false

  description = <<-DESCRIPTION
    Enable backups feature for droplet.
  DESCRIPTION
}

variable "ipv6" {
  type = bool

  default = false

  description = <<-DESCRIPTION
    Enable IPv6 address on droplet.
  DESCRIPTION
}

variable "private_networking" {
  type = bool

  default = true

  description = <<-DESCRIPTION
    Enable DigitalOcean private networking.
  DESCRIPTION
}

variable "monitoring" {
  type = bool

  default = true

  description = <<-DESCRIPTION
    Enable DigitalOcean monitoring.
  DESCRIPTION
}

variable "volume_size" {
  type = number

  default = 150

  description = <<-DESCRIPTION
    Size of data volume in gigabytes.
    If zero, no volume will be created.
  DESCRIPTION
}

variable "trusted_sources" {
  type = list

  description = <<-DESCRIPTION
    Required.
    IP list to allow SSH and bitcoin rpc connections from.
  DESCRIPTION
}

# Provisioner confiuration

variable "provisioner_username" {
  type = string

  default = "provisioner"

  description = <<-DESCRIPTION
    This user will be added and used inside this module only.
  DESCRIPTION
}

# Service configuration

variable "image" {
  type = string

  default = "ethereum/client-go:v1.9.3"

  description = <<-DESCRIPTION
    Geth docker image tag.
  DESCRIPTION
}

variable "verbosity" {
  type = number

  default = 3

  description = <<-DESCRIPTION
    Logging verbosity:
    - 0 - silent
    - 1 - error
    - 2 - warn
    - 3 - info
    - 4 - debug
    - 5 - detail
  DESCRIPTION
}

variable "testnet" {
  type = bool

  default = true

  description = <<-DESCRIPTION
    Use `ropsten` network or main if `false`.
  DESCRIPTION
}

variable "apis" {
  type = list

  default = [
    "web3",
    "eth",
    "admin",
    "net",
    "txpool",
    "db",
    "debug",
  ]

  description = <<-DESCRIPTION
    API's offered over the HTTP-RPC/WS-RPC interface.
    Possible names are:
    - `debug`
    - `admin`
    - `web3`
    - `net`
    - `eth`
    - `db`
    - `txpool`
    - `miner`
    - `personal`
    - `shh`
  DESCRIPTION
}

variable "wsorigins" {
  type = string

  default = "*"

  description = <<-DESCRIPTION
    Origins from which to accept websockets requests.
  DESCRIPTION
}

variable "maxpeers" {
  type = number

  default = 25

  description = <<-DESCRIPTION
    Maximum number of network peers (network disabled if set to 0).
  DESCRIPTION
}

variable "maxpendpeers" {
  type = number

  default = 0

  description = <<-DESCRIPTION
    Maximum number of pending connection attempts (defaults used if set to 0).
  DESCRIPTION
}

variable "syncmode" {
  type = string

  default = "fast"

  description = <<-DESCRIPTION
    Blockchain sync mode:
    - `fast`
    - `full`
    - `light`
  DESCRIPTION
}

variable "gcmode" {
  type = string

  default = "full"

  description = <<-DESCRIPTION
    Blockchain garbage collection mode:
    - `full`
    - `archive
  DESCRIPTION
}

variable "extra_args" {
  type = list

  default = []

  description = <<-DESCRIPTION
    Geth CLI additional arguments.
  DESCRIPTION
}

variable "cache" {
  type = number

  default = 1024

  description = <<-DESCRIPTION
    Megabytes of memory allocated to internal caching.
  DESCRIPTION
}

variable "cache_database" {
  type = number

  default = 75

  description = <<-DESCRIPTION
    Percentage of cache memory allowance to use for database io.
  DESCRIPTION
}

variable "cache_gc" {
  type = number

  default = 25

  description = <<-DESCRIPTION
    Percentage of cache memory allowance to use for trie pruning.
  DESCRIPTION
}

# Exporter configuration

variable "ethereum_exporter" {
  type        = bool
  default     = true
  description = <<-DESCRIPTION
    Installs ethereum-exporter.
  DESCRIPTION
}
