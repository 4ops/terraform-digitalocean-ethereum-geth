data "template_file" "docker_compose_config" {
  template = <<-TEMPLATE
    # Generated by terraform module. Do not edit manually!
    version: '3'

    services:
      instance:
        image: ${var.image}
        restart: always
        volumes:
          - './data:/data'
        ports:
          - '8545:8545'
          - '8546:8546'
          - '30303:30303'
          - '30303:30303/udp'
        command:
          - '--datadir=/data'
          - '--nousb'
          - '--ipcdisable'
          - '--rpc'
          - '--rpcaddr=0.0.0.0'
          - '--rpcvhosts=*'
          - '--ws'
          - '--wsaddr=0.0.0.0'
          - '--wsapi'
          - '--nat=any'
          - '--verbosity=${var.verbosity}'
          - '--networkid=${var.testnet ? 3 : 1}'
          - '--maxpeers=${var.maxpeers}'
          - '--maxpendpeers=${var.maxpendpeers}'
          - '--syncmode=${var.syncmode}'
          - '--gcmode=${var.gcmode}'
          - '--cache=${var.cache}'
          - '--cache.database=${var.cache_database}'
          - '--cache.gc=${var.cache_gc}'
          - '--rpcapi=${join(",", var.apis)}'
          - '--wsapi=${join(",", var.apis)}'
          - '--wsorigins=${var.wsorigins}'
%{ if var.testnet ~}
          - '--testnet'
%{ endif ~}
%{ if length(var.extra_args) > 0 ~}
          ${indent(6, join("\n", formatlist("- '%s'", var.extra_args)))}
%{ endif ~}

%{ if var.ethereum_exporter ~}
      exporter:
        image: 4ops/ethereum-exporter:latest
        restart: always
        depends_on:
          - instance
        links:
          - 'instance:instance'
        ports:
          - '9144:9144'
        environment:
          ETHEREUM_API_URL: 'http://instance:8545'
          LOG_LEVEL: 'info'
%{ endif }
  TEMPLATE
}
