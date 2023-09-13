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

#read yaml for certmanager
#url = "https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml"
data "kubectl_file_documents" "certmanager_docs" {
    content = file("${path.module}/cert-manager.yaml")
}

#apply yaml file for cert managers
resource "kubectl_manifest" "certmanager" {
  for_each  = data.kubectl_file_documents.certmanager_docs.manifests
  yaml_body = each.value
}

#use helm to install cert nginx
resource "helm_release" "ingress-nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress"
  create_namespace = true
  set {
    name = "controller.service.annotations.service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"
    value = "healthz"
  }
}

#use helm to install kyverno
resource "helm_release" "kyverno" {
  name       = "kyverno"
  repository = "https://kyverno.github.io/kyverno/"
  chart      = "kyverno"
  namespace  = "kyverno"
  create_namespace = true
}

#apply yaml to install kured 1.14.0
#url = "https://github.com/kubereboot/kured/releases/download/1.14.0/kured-1.14.0-dockerhub.yaml"
resource "kubectl_manifest" "kured" {
  yaml_body = file("${path.module}/kured-1.14.0-dockerhub.yaml")
}

#apply yaml to install tekton
#url = "https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml"
resource "kubectl_manifest" "tekton" {
  yaml_body = file("${path.module}/tekton.yaml")
}