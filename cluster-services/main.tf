provider "helm" {
  kubernetes {
    config_path = "$HOME/.kube/config"
  }
}

provider "kubectl" {
  config_path = "$HOME/.kube/config"
}

#use helm to install kyverno
resource "helm_release" "kyverno" {
  name       = "kyverno"
  repository = "https://kyverno.gitlab.io/kyverno"
  chart      = "kyverno"
  namespace  = "kyverno"
}

#download yaml for kured 1.14.0
data "http" "kured_yaml" {
  url = "https://github.com/kubereboot/kured/releases/download/1.14.0/kured-1.14.0-dockerhub.yaml"
}

#apply yaml to install kured 1.14.0
resource "kubectl_manifest" "kured" {
  yaml_body = data.http.kured_yaml.body
}

#download yaml for tekton
data "http" "tekton_yaml" {
  url = "https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml"
}

#apply yaml to install tekton
resource "kubectl_manifest" "tekton" {
  yaml_body = data.http.tekton_yaml.body
}