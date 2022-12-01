output "app_name" {
  value = azurerm_linux_function_app.tektutor.name
}

output "function_url" {
  value = "${azurerm_function_app_function.tektutor.invocation_url}?"
}
