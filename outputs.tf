# Module owners should include the full resource via a 'resource' output
# https://azure.github.io/Azure-Verified-Modules/specs/terraform/#id-tffr2---category-outputs---additional-terraform-outputs
output "resource" {
  value       = azurerm_storage_account.this
  description = "This is the full resource output for the Storage Account resource."
}

output "private_endpoints" {
  value       = azurerm_private_endpoint.this
  description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
}

output "storage_container" {
  description = "Map of storage containers that are created."
  value = {
    for name, container in azapi_resource.storage_container :
    name => {
      id                    = container.id
      name                  = container.name
      storage_account_name  = jsondecode(container.output).properties.storage_account_name
      container_access_type = jsondecode(container.output).properties.container_access_type
      metadata              = jsondecode(container.output).properties.metadata
    }
  }
}

output "storage_queue" {
  description = "Map of storage queues that are created."
  value = {
    for name, queue in azurerm_storage_queue.this :
    name => {
      id                   = queue.id
      name                 = queue.name
      storage_account_name = queue.storage_account_name
      metadata             = queue.metadata
    }
  }
}

output "storage_table" {
  description = "Map of storage tables that are created."
  value = {
    for name, table in azurerm_storage_table.this : name => {
      id                   = table.id
      name                 = table.name
      storage_account_name = table.storage_account_name
    }
  }
}
