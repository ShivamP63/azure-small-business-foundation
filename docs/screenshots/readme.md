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
| 22 | [22-log-analytics-workspace-overview.png](22-log-analytics-workspace-overview.png) | Azure Log Analytics Workspace deployed with centralized monitoring configuration. |
| 23 | [23-log-analytics-retention-settings.png](23-log-analytics-retention-settings.png) | Log Analytics Workspace configured with a 30-day data retention policy for cost-effective monitoring. |
| 24 | [24-azure-monitor-agent-extension.png](24-azure-monitor-agent-extension.png) | Azure Monitor Agent successfully installed and provisioned on the Linux virtual machine. |
| 25 | [25-data-collection-rule-overview.png](25-data-collection-rule-overview.png) | Azure Monitor Data Collection Rule deployed for centralized Linux VM monitoring. |
| 26 | [26-data-collection-rule-data-sources.png](26-data-collection-rule-data-sources.png) | Data Collection Rule configured to collect Linux performance counters and Syslog events. |
| 27 | [27-data-collection-rule-destination.png](27-data-collection-rule-destination.png) | Log Analytics Workspace configured as the destination for collected monitoring data. |
| 28 | [28-data-collection-rule-association.png](28-data-collection-rule-association.png) | Data Collection Rule successfully associated with the Linux virtual machine. |
| 29 | [29-heartbeat-kql-results.png](29-heartbeat-kql-results.png) | Kusto Query Language (KQL) query verifying successful Azure Monitor Agent heartbeat communication. |
| 30 | [30-performance-counters-kql-results.png](30-performance-counters-kql-results.png) | KQL query validating collection of Linux CPU, memory, and disk performance metrics. |
| 31 | [31-syslog-kql-results.png](31-syslog-kql-results.png) | KQL query confirming successful ingestion of Linux Syslog events into Log Analytics. |
| 32 | [32-action-group-overview.png](32-action-group-overview.png) | Azure Monitor Action Group configured to deliver email notifications for monitoring alerts. |
| 33 | [33-high-cpu-alert-rule.png](33-high-cpu-alert-rule.png) | High CPU metric alert configured to detect sustained virtual machine CPU utilization above the defined threshold. |
| 34 | [34-heartbeat-alert-rule.png](34-heartbeat-alert-rule.png) | Scheduled Query alert configured to detect missing Azure Monitor heartbeats from the Linux virtual machine. |
| 35 | [35-high-cpu-alert-email-fired.png](35-high-cpu-alert-email-fired.png) | Azure Monitor email notification confirming the High CPU metric alert fired successfully. |
| 36 | [36-high-cpu-alert-email-resolved.png](36-high-cpu-alert-email-resolved.png) | Azure Monitor email notification confirming the High CPU metric alert resolved automatically after CPU utilization returned to normal. |
| 37 | [37-heartbeat-alert-email-fired.png](37-heartbeat-alert-email-fired.png) | Azure Monitor email notification confirming the missing heartbeat alert fired successfully after the virtual machine was stopped. |
| 38 | [38-heartbeat-alert-email-resolved.png](38-heartbeat-alert-email-resolved.png) | Azure Monitor email notification confirming heartbeat monitoring resumed successfully after the virtual machine was restarted. |
| 39 | [39-recovery-services-vault-overview.png](39-recovery-services-vault-overview.png) | Recovery Services Vault configured to protect Azure virtual machines using locally redundant backup storage. |
| 40 | [40-vm-backup-item-overview.png](40-vm-backup-item-overview.png) | Protected virtual machine showing backup configuration, protection status, and associated backup policy. |
| 41 | [41-backup-job-completed.png](41-backup-job-completed.png) | Completed on-demand Azure Backup job confirming successful creation of the initial virtual machine backup. |
| 42 | [42-vm-recovery-point.png](42-vm-recovery-point.png) | Recovery point created successfully for the virtual machine with a file-system-consistent backup. |

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
- Azure Monitor Agent for centralized VM monitoring
- Data Collection Rules for controlled telemetry collection
- Centralized Log Analytics Workspace
- Linux performance monitoring (CPU, memory, and disk)
- Centralized Linux Syslog collection
- Kusto Query Language (KQL) used to validate monitoring data ingestion


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