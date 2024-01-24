terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.67.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "allianz-sa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    access_key           = "allianz-key"
  }

}
