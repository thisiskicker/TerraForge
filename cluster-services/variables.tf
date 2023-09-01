resource "local_sensitive_file" "kconfig_file" {
    content = var.kconfig
    filename = "${path.module}/kconfig"
}

variable "kconfig" {
    type = string
    default = ""
    sensitive = true
}

# variable "kcontext" {
#     type = string
#     default = ""
# }