# Deployment Evidence Gallery

This gallery contains **42 sequential screenshots** that demonstrate the deployed state and validation of the Azure Small-Business Foundation project. Identifiers and sensitive values are redacted where appropriate; no passwords, keys, secret values, or access tokens are included.

## How to Review the Evidence

The sequence follows the implementation lifecycle: governance → network → compute → storage → secrets → monitoring → alerts → backup. Each filename begins with a stable two-digit number so links remain predictable.

## Screenshot Index

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


## Evidence Coverage

| Area | Screenshots |
|---|---|
| Governance and organization | 01–02 |
| Network and private VM | 03–11 |
| Storage and RBAC | 12–16 |
| Key Vault and managed identity | 17–21 |
| Log Analytics, AMA, DCR, and KQL | 22–31 |
| Action group and alert validation | 32–38 |
| Recovery Services vault and backup | 39–42 |

## Security and Operations Highlights

- Private VM with no public IP
- Subnet-level NSG and effective-rule validation
- SSH-key authentication and controlled Run Command administration
- System-assigned managed identity and least-privilege RBAC
- Private blob container and Entra ID data-plane access
- Key Vault RBAC, soft delete, and purge protection
- Centralized Heartbeat, performance, and Syslog collection
- Fired and resolved CPU and heartbeat alert notifications
- Successful VM backup job and file-system-consistent recovery point

## Screenshot Standards

Screenshots are evidence, not deployment instructions. Resource identifiers are shown only where useful for review. Subscription IDs, tenant IDs, email addresses, secret values, access tokens, and other sensitive data should remain obscured before publishing.
