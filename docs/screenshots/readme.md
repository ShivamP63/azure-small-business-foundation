# Azure Small-Business Foundation – Screenshot Gallery

This directory contains screenshots captured throughout the deployment and validation of the **Azure Small-Business Foundation** project.

The screenshots provide visual evidence that every major deployment, configuration change, and security validation was completed successfully.

---

## Deployment Timeline

| # | Screenshot | Description |
|---|------------|-------------|
| 01 | [01-budget-alert.png](01-budget-alert.png) | Azure Budget and Cost Alert configured for the subscription. |
| 02 | [02-resource-groups.png](02-resource-groups.png) | Resource groups created following workload separation (Network, Workload, Security, Management). |
| 03 | [03-vnet-subnets.png](03-vnet-subnets.png) | Virtual Network with dedicated subnets deployed. |
| 04 | [04-existing-network-foundation.png](04-existing-network-foundation.png) | Existing network infrastructure validated before deploying workload resources. |
| 05 | [05-private-nic-configuration.png](05-private-nic-configuration.png) | Private Network Interface configured without a Public IP address. |
| 06 | [06-private-vm-overview.png](06-private-vm-overview.png) | Ubuntu Linux virtual machine successfully deployed. |
| 07 | [07-system-assigned-managed-identity.png](07-system-assigned-managed-identity.png) | System-assigned Managed Identity enabled for the VM. |
| 08 | [08-boot-diagnostics.png](08-boot-diagnostics.png) | Boot Diagnostics enabled and verified. |
| 09 | [09-nginx-run-command-validation.png](09-nginx-run-command-validation.png) | Azure Run Command used to verify cloud-init and Nginx installation. |
| 10 | [10-vm-auto-shutdown.png](10-vm-auto-shutdown.png) | Automatic VM shutdown configured for cost optimization. |
| 11 | [11-effective-network-security.png](11-effective-network-security.png) | Effective Network Security Rules verified after NSG association. |
| 12 | [12-storage-account-overview.png](12-storage-account-overview.png) | Azure Storage Account successfully deployed. |
| 13 | [13-storage-security-settings.png](13-storage-security-settings.png) | Storage Account security configuration validated (HTTPS, TLS 1.2, Blob Access, etc.). |
| 14 | [14-workload-resource-group.png](14-workload-resource-group.png) | Workload Resource Group showing deployed infrastructure. |
| 15 | [15-private-blob-container.png](15-private-blob-container.png) | Private Blob Container created successfully. |
| 16 | [16-storage-rbac.png](16-storage-rbac.png) | Azure RBAC configured for Microsoft Entra ID Blob access. |
| 17 | [17-key-vault-overview.png](17-key-vault-overview.png) | Azure Key Vault deployed successfully. |
| 18 | [18-key-vault-security-settings.png](18-key-vault-security-settings.png) | Key Vault security configuration validated (RBAC, Purge Protection, Soft Delete). |
| 19 | [19-key-vault-secret.png](19-key-vault-secret.png) | Sample secret created within Azure Key Vault. |
| 20 | [20-key-vault-managed-identity-rbac.png](20-key-vault-managed-identity-rbac.png) | Managed Identity granted least-privilege access to Azure Key Vault. |
| 21 | [21-managed-identity-secret-retrieval.png](21-managed-identity-secret-retrieval.png) | Secret successfully retrieved from Azure Key Vault using the VM's Managed Identity without stored credentials. |

---

## Security Highlights

The screenshots demonstrate implementation of several Azure security best practices:

- Private virtual machine without a Public IP address
- Network Security Groups enforcing least-privilege access
- System-assigned Managed Identity
- Azure RBAC authorization
- Microsoft Entra ID authentication
- Azure Key Vault for centralized secret management
- Private Blob Storage
- HTTPS-only Storage Account
- Minimum TLS 1.2 enforcement
- Purge Protection and Soft Delete enabled
- Secure secret retrieval without passwords, connection strings, or access keys

---

## Notes

This repository is intended as a **Azure administration project** demonstrating practical skills relevant to:

- Azure Administrator
- Cloud Administrator
- Cloud Engineer
- DevOps Engineer
- Site Reliability Engineer (SRE)
- Platform Engineer

Where appropriate, subscription identifiers, tenant identifiers, and other environment-specific information have been redacted from screenshots. No secrets, passwords, access keys, or authentication tokens are stored in this repository.