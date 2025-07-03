resource "azurerm_resource_group" "name" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_key_vault" "name" {
  name                = "example-kv"
  location            = azurerm_resource_group.name.location
  resource_group_name = azurerm_resource_group.name.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}


resource "azurerm_virtual_machine" "name" {
  name                  = "example-vm"
  location              = azurerm_resource_group.name.location
  resource_group_name   = azurerm_resource_group.name.name
  network_interface_ids = [azurerm_network_interface.name.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}


