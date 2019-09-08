output "name" {
  value = concat(
    module.development_fast.name,
    module.development_full.name,
    module.production_fast.name,
    module.production_full.name,
  )
}

output "ipv4" {
  value = concat(
    module.development_fast.ipv4,
    module.development_full.ipv4,
    module.production_fast.ipv4,
    module.production_full.ipv4,
  )
}
