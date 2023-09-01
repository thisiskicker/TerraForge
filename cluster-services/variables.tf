resource "local_sensitive_file" "kconfig" {
    content = terraform.workspace.var.kconfig
    filename = "${path.module}/kconfig"
}