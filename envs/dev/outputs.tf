output "approle_role_id" {
  value = module.approle.approle_role_id.role_id
}

output "approle_secret_id" {
  value = module.approle.approle_secret_id
}