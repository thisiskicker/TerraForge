# Terraforge Notes

## Chainguard Container Image

- The Chainguard container image is based on a distroless nginx image, designed to be a drop-in replacement for the generic nginx image.
- Note that due to its distroless nature, ports 1-1024 cannot be used. Instead, it is configured to use port 8080.

## Trivy - GitHub Actions

- Adding the Trivy scanner for container images is a straightforward process. However, it's important to note that the value for `image-ref` in the Trivy scanner step should not contain any uppercase letters.

## Azure - Authorization

- For authentication in Azure, it's recommended to use app registration since Terraform Cloud is hosted outside of Azure.
- Managed Service Identities (MSIs) only function within Azure or GitHub environments.
- When trying to pass the kubeconfig through Terraform Cloud, it can be a bit more challenging and less reliable. In such cases, using a service principal is advised, especially when interacting with the Azure API from outside of Azure or GitHub.

## Azure - Nginx Ingress

- Adding this annotation to the nginx helm install is required to get the azure health check to probe the correct endpoint. If not nginx ingress will not work.
  ```service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path: /healthz```

## Terraform

- The TLS provider in Terraform simplifies the installation of Linkerd by allowing the generation and management of CA and root TLS certificates directly within Terraform, eliminating the need to manually generate and reference certificate files.

- It's worth noting that Terraform Cloud may not permit the `http` module to download files directly from the internet. In such cases, you should save the files into the repository and directly reference the tracked files for a seamless integration.

- When using the `kubectl` module without a kubeconfig file, ensure to include the option `load_config_file = false` in the provider configuration:

```hcl
provider "kubectl" {
  load_config_file = false
}
