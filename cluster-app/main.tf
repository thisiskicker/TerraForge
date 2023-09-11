#use helm to install the terraforge app
resource "helm_release" "terraforge-app" {
  name       = "terraforge-app"
  repository = "../terraforge-app-chart"
  chart      = "terraforge-app"
  namespace = "terraforge"
  create_namespace = true
}

#create cluster issuer
resource "kubectl_manifest" "cluster_issuer" {
  yaml_body = file("${path.module}/cert-files/cluster-issuer.yml")
  
}

#create ssl cert
resource "kubectl_manifest" "terraforge_cert" {
  yaml_body = file("${path.module}/cert-files/certificate-issuer.yml")
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