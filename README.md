# Ethereum Geth

- Creates virtual server(s) with docker
- Creates cloud volume(s) and mount to /srv
- Register server(s) in domain `var.domain`
- Creates cloud firewall and apply network policy to server(s)
- Deploy geth in `/srv/ethereum`

## Components

_Geth_ Official Go implementation of the Ethereum protocol.

- [Official website](https://geth.ethereum.org)
- [Docker image](https://hub.docker.com/r/ethereum/client-go)

## Cloud resources

- DigitalOcean droplet
- DigitalOcean volume
- DigitalOcean cloud firewall

## Default firewall rules

### Incoming

- Allow SSH from `var.trusted_sources`

### Outgoing

- Allow tcp to world
- Allow udp to world
- Allow icmp to world
