output "config" {
  value       = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
  sensitive   = true
  description = "The raw Kubernetes config to access the AKS cluster. Marked as sensitive to avoid being displayed in CLI output"
}