resource "azurerm_public_ip" "public-nic" {
  name                = "public"
  resource_group_name = var.resource_group
  location            = var.azure_region
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "private-nic" {
  name                = "private"
  location            = var.azure_region
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/3dc3cd1a-d5cd-4e3e-a648-b2253048af83/resourceGroups/cdsimplifiedv2/providers/Microsoft.Network/virtualNetworks/cdsimplifiedv2vnet532/subnets/default"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public-nic.id
  }
}


resource "azurerm_virtual_machine" "integration-env" {
  name                = "integration-env"
  resource_group_name = var.resource_group
  location            = var.azure_region
  vm_size             = "Standard_D2s_v3"

  network_interface_ids = [
    azurerm_network_interface.private-nic.id,  
  ]


os_profile_windows_config  {}

  storage_os_disk {
    name            = "selenium-windows-disk"
    os_type         = "windows"
    managed_disk_id = "/subscriptions/3dc3cd1a-d5cd-4e3e-a648-b2253048af83/resourcegroups/cdsimplifiedv2/providers/Microsoft.Compute/disks/selenium-windows-disk"
    create_option   = "Attach"
  }

  //source_image_id = "/subscriptions/3dc3cd1a-d5cd-4e3e-a648-b2253048af83/resourcegroups/cdsimplifiedv2/providers/Microsoft.Compute/disks/selenium-windows-disk"
  /*source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "20h2-pro"
    version   = "latest"
  }*/
}