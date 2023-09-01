#use helm to install linkerd crds
resource "helm_release" "linkerd-crds" {
  name       = "linkerd-crds"
  repository = "https://helm.linkerd.io/stable/"
  chart      = "linkerd-crds"
  create_namespace = true
}

#use helm to install linkerd control plane
resource "helm_release" "linkerd-control-plane" {
  name       = "linkerd-control-plane"
  repository = "https://helm.linkerd.io/stable/"
  chart      = "linkerd-control-plane"
  namespace = helm_release.linkerd-crds.namespace
  set {
    name  = "identityTrustAnchorsPEM"
    value = tls_locally_signed_cert.issuer.ca_cert_pem
  }
  set {
    name  = "identity.issuer.tls.crtPEM"
    value = tls_locally_signed_cert.issuer.cert_pem
  }
  set {
    name  = "identity.issuer.tls.keyPEM"
    value = tls_private_key.issuer.private_key_pem
  }
}

#download yaml for certmanager
data "http" "certmanager_yaml" {
  url = "https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml"
}

#apply yaml for certmanager crds
resource "kubectl_manifest" "certmanager_crd" {
  yaml_body = data.http.certmanager_yaml.response_body
}

# #use helm to install cert nginx
# resource "helm_release" "ingress-nginx" {
#   name       = "ingress-nginx"
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart      = "ingress-nginx"
#   namespace  = "ingress"
#   create_namespace = true
# }

#use helm to install kyverno
resource "helm_release" "kyverno" {
  name       = "kyverno"
  repository = "https://kyverno.github.io/kyverno/"
  chart      = "kyverno"
  namespace  = "kyverno"
  create_namespace = true
}

#download yaml for kured 1.14.0
data "http" "kured_yaml" {
  url = "https://github.com/kubereboot/kured/releases/download/1.14.0/kured-1.14.0-dockerhub.yaml"
}

#apply yaml to install kured 1.14.0
resource "kubectl_manifest" "kured" {
  yaml_body = data.http.kured_yaml.response_body
}

#download yaml for tekton
data "http" "tekton_yaml" {
  url = "https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml"
}

#apply yaml to install tekton
resource "kubectl_manifest" "tekton" {
  yaml_body = data.http.tekton_yaml.response_body
}