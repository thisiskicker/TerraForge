# TerraForge

TerraForge is a basic web app designed to run on Kubernetes in Azure.

## Overview

TerraForge simplifies the deployment and management of the web application by providing a structured Kubernetes setup in the Azure cloud environment. It is divided into three main components:

1. **Cluster**: Create an Azure Kubernetes Service (AKS) cluster to serve as the foundation for your application.

2. **Cluster Services**: Install essential base services on the AKS cluster. These services include:

    - [Linkerd Service Mesh](https://linkerd.io/): A powerful service mesh for Kubernetes, enabling secure, observable communication between services.
    - [Cert Manager](https://cert-manager.io/): A Kubernetes add-on for managing TLS certificates, ensuring secure communication within your cluster.
    - [Nginx Ingress](https://kubernetes.github.io/ingress-nginx/): An Ingress controller for routing external traffic to your services.
    - [Kyverno](https://kyverno.io/): A policy management solution for Kubernetes, enforcing custom policies and security controls.
    - [Kured](https://github.com/weaveworks/kured): A Kubernetes reboot daemon for automated node reboots to apply security updates.
    - [Tekton](https://tekton.dev/): A cloud-native CI/CD framework to automate building, testing, and deploying your applications.

3. **Cluster App**: Configure SSL certificates, and install and manage your TerraForge web application.

## Getting Started

To get started with TerraForge, follow these steps:

1. **Terraform Cloud Configuration**: Before proceeding, configure Terraform Cloud with your repository to enable automated infrastructure deployment. Please refer to the [Terraform Cloud Documentation](https://www.terraform.io/docs/cloud/index.html) for details on setting up Terraform Cloud with your project.

2. **Cluster Setup**: Create an AKS cluster in Azure. Ensure that the cluster meets your application's requirements, including scalability and availability.

3. **Cluster Services**: Install the base services using TerraForge. This includes Linkerd for service mesh, Cert Manager for certificate management, Nginx Ingress for routing, Kyverno for policy management, Kured for automated node reboots, and Tekton for CI/CD.

4. **Cluster App Configuration**: Configure SSL certificates for secure communication. Install and configure TerraForge for hosting your web application content.