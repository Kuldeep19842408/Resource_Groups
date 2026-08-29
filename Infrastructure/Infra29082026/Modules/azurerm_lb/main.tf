data "azurerm_public_ip" "lb_pip" {
  for_each            = { for k, v in var.lb : k => v if lookup(v, "public_ip_name", null) != null }
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_lb" "lb" {
  for_each            = var.lb
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = lookup(each.value, "sku", "Standard")

  frontend_ip_configuration {
    name                 = lookup(each.value, "frontend_name", "PublicIPAddress")
    public_ip_address_id = lookup(each.value, "public_ip_address_id", null) != null ? each.value.public_ip_address_id : (lookup(each.value, "public_ip_name", null) != null ? data.azurerm_public_ip.lb_pip[each.key].id : null)
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each        = var.lb
  loadbalancer_id = azurerm_lb.lb[each.key].id
  name            = lookup(each.value, "backend_pool_name", "BackEndAddressPool")
}

resource "azurerm_lb_probe" "probe" {
  for_each        = var.lb
  loadbalancer_id = azurerm_lb.lb[each.key].id
  name            = lookup(each.value, "probe_name", "http-probe")
  port            = lookup(each.value, "probe_port", 80)
  protocol        = lookup(each.value, "probe_protocol", "Http")
  request_path    = lookup(each.value, "probe_protocol", "Http") == "Http" || lookup(each.value, "probe_protocol", "Http") == "Https" ? lookup(each.value, "request_path", "/") : null
}

resource "azurerm_lb_rule" "rule" {
  for_each                       = var.lb
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  name                           = lookup(each.value, "rule_name", "LBRule")
  protocol                       = lookup(each.value, "rule_protocol", "Tcp")
  frontend_port                  = lookup(each.value, "frontend_port", 80)
  backend_port                   = lookup(each.value, "backend_port", 80)
  frontend_ip_configuration_name = lookup(each.value, "frontend_name", "PublicIPAddress")
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.probe[each.key].id
}
