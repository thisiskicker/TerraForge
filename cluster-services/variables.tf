# variable "kconfig" {
#     type = string
#     default = ""
#     sensitive = true
# }

resource "local_sensitive_file" "kconfig_file" {
    content = var.kconfig
    filename = "${path.module}/kconfig"
}