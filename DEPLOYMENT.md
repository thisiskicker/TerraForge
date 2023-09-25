# Web App Deployment on Azure using Terraform Cloud

## Requirements

- GitHub Personal Access Tokens (PATs):
    - For image pull secrets
    - To read repositories and upload images
      
- Terraform Cloud Credentials
  
- Azure Service Principle
  
- Domain
  
## Instructions

### 1. Configure Terraform Cloud

a. Create Organization

b. Create 3 Workspaces:
   - Terraforge-Cluster
   - Terraforge-Services
   - Terraforge-App

c. Configure a Variable Set (All Sensitive) - Azure Details:
   - ARM_CLIENT_ID
   - ARM_CLIENT_SECRET
   - ARM_SUBSCRIPTION_ID
   - ARM_TENANT_ID
   
d. Configure Workspace Variables:
   - **Terraforge-Cluster**
     1. cluster_name
     2. kubernetes_version
     3. location
     4. node_resource_group
     5. resource_group_name
     6. system_node_count
   - **Terraforge-App**
     1. REGCRED

### 2. Configure GitHub Actions

a. Add Variables:
   - TF_CLOUD_ORGANIZATION

b. Add Secrets:
   - TF_TOKEN

### 3. Customize Files for Terraforge App Deployment

a. Modify `cluster-app/cert-files/cluster-issuer.yml`:
   - Change the email.

b. Modify `cluster-app/cert-files/certificate.yml`:
   - Change commonName.
   - Change dnsNames.

c. Modify `cluster-app/terraforge-app-chart/values.yaml`:
   - Modify `ingress.hosts[0].host`.
   - Modify `ingress.tls[0].hosts[0]`.

### 4. Deploy Terraforge

Run the following steps in GitHub Actions:

    a. Run Cluster-Base Workflow.
    
    b. Run Cluster-Services Workflow.
    
    c. Run Cluster-App Workflow.
