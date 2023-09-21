#docker formated image pull secret
#to be injected by terraform cloud at runtime
variable "REGCRED" {
  type = string
  description = "image pull secret"
}