locals {
  # Convert comma-separated string to list
  all_vm_sizes = split(",", data.external.vm_available.result["vm_sizes"])

  # Example filter: only Standard_B series
  series_vm_sizes = [
    for size in local.all_vm_sizes : size
    if can(regex("^${var.vm_type.type}_v${var.vm_type.cores}", size))
  ]

  tags_map = merge(var.default_tags, var.extra_tags)
  tags_set = toset([
    for k, v in local.tags_map : "${k}=${v}"
  ])
}
