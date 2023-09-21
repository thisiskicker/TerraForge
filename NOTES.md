Chainguard container image
    chainguard already has a distroless nginx image.
    it can be used as a drop in replacement for the generic nginx image.
    since it's a distroless image port 1-1024 can't be used it's configured to use port 8080.

Trivy - github actions
    Adding the Trivy scanner for the container images was not too difficult, but there was one thing that caused a slight issue. The value image-ref for the trivy scanner step must not contain uppercase letters.

Azure - authorization
    Use app registration for authentication because Terraform Cloud is hosted outside of Azure.
    Managed Service IDs only work from Azure or Github.
    It turns out trying to pipe in the kubeconfig through terraform cloud is a bit more troublesome and fragile.
    Need to use a service principle if you're using the azure api from outsite of azure or github.

Terraform
    The TLS provider in terraform makes installing linkerd significantly easier. It allows me to generate and manage the ca and root tls certificates within terraform instead of generating the certificates and pointing to the files.
    Terraform cloud does not seem to allow the data http module to download files straight from the internet.
    The option load_config_file = false is important to have when using the kubectl module when not using a kubeconfig file.

    ```provider "kubectl" {
    load_config_file = false```