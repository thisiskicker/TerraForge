# resource "kubernetes_namespace" "terraforge" {
#   metadata {
#     annotations = {
#       name = "terraforge"
#       "linkerd.io/inject" = "enabled"
#     }
#     name = "terraforge"
#   }
# }

# #use helm to install the terraforge app
# resource "helm_release" "terraforge-app" {
#   name       = "terraforge-app"
#   repository = "${path.module}"
#   chart      = "terraforge-app-chart"
#   namespace = kubernetes_namespace.terraforge.metadata[0].name
#   #create_namespace = true
# }

# # #create cluster issuer
# # resource "kubectl_manifest" "cluster_issuer" {
# #   yaml_body = file("${path.module}/cert-files/cluster-issuer.yml")
# # }

# # #create ssl cert
# # resource "kubectl_manifest" "terraforge_cert" {
# #   yaml_body = file("${path.module}/cert-files/certificate.yml")
# #   namespace = helm_release.terraforge-app.namespace
# # }

# #create image pull secret for custom images
# #it just needs the config file unencoded
# resource "kubernetes_secret" "regcred" {
#   metadata {
#     name = "regcred"
#     namespace = kubernetes_namespace.terraforge.metadata[0].name
#   }
#   data = {
#     ".dockerconfigjson" = var.REGCRED
#   }
#   type = "kubernetes.io/dockerconfigjson"
# }