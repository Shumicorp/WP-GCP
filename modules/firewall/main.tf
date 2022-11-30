resource "google_compute_firewall" "rules" {
  for_each                = var.firewall
  name                    = each.value.name
  description             = each.value.description
  direction               = each.value.direction
  network                 = var.network.name
  priority                = each.value.priority
  target_tags             = each.value.target_tags
  target_service_accounts = each.value.target_service_accounts
  destination_ranges      = each.value.destination_ranges
  source_ranges           = each.value.source_ranges
  source_tags             = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts

  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }
  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}