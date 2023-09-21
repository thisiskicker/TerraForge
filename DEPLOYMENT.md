Requirements:
    Github PAT for image pull secrets
    Github PAT to read repo and upload images
    Terraform Cloud Credentials
    Azure Service Principle
    Domain

Instructions to deploy.

    1. Configure terraform cloud
        a. create organization
        b. create 3 workspaces
            - Terraforge-Cluster
            - Terraforge-Services
            - Terraforge-App
        c. configure a variable set (all sensitive ) - Azure details
            - ARM_CLIENT_ID
            - ARM_CLIENT_SECRET
            - ARM_SUBSCRIPTION_ID
            - ARM_TENANT_ID
        d. configure workspace variables
            - Terraforge-Cluster
                1. cluster_name
                2. kubernetes_version
                3. location
                4. node_resource_group
                5. resource_group_name
                6. system_node_count
            - Terraforge-App
                1. REGCRED

    2. Configure github actions
        a. ADD variables
            - TF_CLOUD_ORGANIZATION
        b. Add secrets
            - TF_TOKEN

    3. Files to customize to deploy a copy of the Terraforge app
        a. cluster-app/cert-files/cluster-issuer.yml
            - change the email
        b. cluster-app/cert-files/certificate.yml
            - change commonName
            - change dnsNames
        c. cluster-app/terraforge-app-chart/values.yaml
            - ingress.hosts[0].host
            - ingress.tls[0].hosts[0]

    4. Deploy Terraforge - run in 3 github actions
        a. run cluster-base workflow
        b. run cluster-services workflow
        c. run cluster-app workflow