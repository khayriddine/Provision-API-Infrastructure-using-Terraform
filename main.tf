provider "azurerm"{
    version = "~>2.5.0"
    features {

    }
}

terraform {
  backend "azurerm"{
      resource_group_name ="tfstategrp"
      storage_account_name= "tfstorageacc123"
      container_name ="tfstate"
      key= "terraform.tfstate"
  }
}


resource "azurerm_resource_group" "tfgroup"{
    name ="tfmainrg"
    location="westeurope"
}

resource "azurerm_container_group" "tfcg"{
    name ="weatherapi"
    location = azurerm_resource_group.tfgroup.location
    resource_group_name=azurerm_resource_group.tfgroup.name

    ip_address_type= "public"
    dns_name_label= "myweatherapiterraform"
    os_type ="Linux"

    container{
        name ="weatherapi"
        image ="khayriddine/weatherapi"
        cpu ="1"
        memory= "1"

        ports{
            port = 80
            protocol ="TCP"
        }
    }
}