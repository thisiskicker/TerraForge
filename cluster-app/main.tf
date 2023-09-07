#use helm to install the terraforge app
resource "helm_release" "terraforge-app" {
  name       = "terraforge-app"
  repository = "../terraforge-app-chart"
  chart      = "terraforge-app"
  namespace = terraforge
  create_namespace = true
}

#create cluster issuer
resource "kubernetes_manifest" "cluster_issuer" {
  manifest = file("${path.module}/../cert-files/cluster-issuer.yaml")
}

#create ssl cert
resource "kubernetes_manifest" "terraforge_cert" {
  manifest = file("${path.module}/../cert-files/certificate-issuer.yaml")
}

#create image pull secret for custom images
resource "kubernetes_secret" "regcred" {
  metadata {
    name = "regcred"
  }
  data = {
    ".dockerconfigjson" = "var.REGCRED"
  }
  type = "kubernetes.io/dockerconfigjson"
}