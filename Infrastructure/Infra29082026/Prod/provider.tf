terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version="4.81.0"
    }
  }
}

provider "azurerm" {
    subscription_id="72b0382c-3618-4b40-8fa7-98a41ddca4b8"
    features{}
  
}