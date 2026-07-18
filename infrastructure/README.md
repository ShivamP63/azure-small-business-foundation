# Infrastructure and Validation Notes

This directory contains the reproducible artifacts used in the Azure Small-Business Foundation lab. Most Azure resources were created and validated interactively with Azure CLI so that each administration step could be understood and documented. The version-controlled Bicep template covers the Linux monitoring Data Collection Rule.

## Files

| Path | Purpose |
|---|---|
| `cloud-init.yaml` | Installs and starts Nginx during VM provisioning |
| `env/project.env` | Non-secret project names and tag values |
| `monitoring/dcr-linux-monitoring.bicep` | Linux performance and Syslog collection rule |
| `../scripts/deploy.sh` | Validates the Azure session and deploys/updates the DCR |
| `../scripts/cleanup.sh` | Guarded project cleanup helper |

Do not place subscription IDs, passwords, tokens, SSH private keys, storage keys, or secret values in tracked files.

## Final Resource Layout

| Area | Resource group | Main resources |
|---|---|---|
| Network | `rg-contoso-network-dev` | VNet, three subnets, workload NSG |
| Workload | `rg-contoso-workload-dev` | Private NIC, Ubuntu VM, storage account/container |
| Security | `rg-contoso-security-dev` | Key Vault and RBAC assignments |
| Operations | `rg-contoso-management-dev` | Log Analytics, DCR, alerts, action group, Recovery Services vault |

## VM Provisioning

The NIC and VM are in the workload resource group while the subnet is in the network resource group, so the NIC references the subnet by full resource ID.

The VM configuration includes:

- No public IP
- SSH-key authentication
- System-assigned managed identity
- Standard LRS OS disk
- Nginx installed through cloud-init
- Boot diagnostics
- Auto-shutdown
- Azure Monitor Agent

Azure Run Command was used for controlled validation. Azure Bastion was intentionally excluded from the final lab scope.

## Storage and Key Vault

The StorageV2 account enforces HTTPS and TLS 1.2, disables anonymous blob access, and contains a private container. Blob operations were validated with Entra ID and Azure RBAC.

Key Vault uses Azure RBAC, soft delete, and purge protection. The VM's managed identity has `Key Vault Secrets User`; the administrator has `Key Vault Secrets Officer`. Validation confirmed secret retrieval without storing credentials on the VM.

## Monitoring DCR Deployment

Prerequisites:

- Azure CLI authenticated to the intended subscription
- Existing management resource group
- Existing Log Analytics workspace
- Bicep support available through Azure CLI

Validate the template locally:

```bash
az bicep build --file infrastructure/monitoring/dcr-linux-monitoring.bicep
```

Deploy through the guarded helper:

```bash
export SUBSCRIPTION_ID='<subscription-id>'
export LOG_ANALYTICS_WORKSPACE_ID='<full-resource-id>'
./scripts/deploy.sh
```

The script performs a `what-if` before deployment and never creates the VM, Key Vault, storage account, or backup vault.

## Monitoring Configuration

| Component | Final configuration |
|---|---|
| Workspace | `law-contoso-monitoring-dev`, PerGB2018, 30-day retention |
| Agent | Azure Monitor Agent on `vm-contoso-app-dev-01` |
| DCR | CPU, available memory, disk free space, selected Linux Syslog |
| Alerts | CPU above 80%; missing heartbeat for more than five minutes |
| Notifications | Email through `ag-contoso-operations-dev` |

Use the checked-in queries under [`../queries/`](../queries/) for health and security investigation.

## Backup Configuration

The Recovery Services vault `rsv-contoso-backup-dev` is in Canada Central and uses LRS. VM protection was enabled, an on-demand backup completed, and a file-system-consistent recovery point was verified.

## Validation Checklist

```bash
az account show --output table
az group list --query "[?starts_with(name, 'rg-contoso-')].[name,location]" --output table
az vm get-instance-view --resource-group rg-contoso-workload-dev --name vm-contoso-app-dev-01 --query "instanceView.statuses[?starts_with(code,'PowerState/')].displayStatus" --output tsv
az monitor data-collection rule show --resource-group rg-contoso-management-dev --name dcr-contoso-vm-dev --output table
az backup job list --resource-group rg-contoso-management-dev --vault-name rsv-contoso-backup-dev --output table
```

## Cleanup

Read [docs/runbooks/resource-cleanup.md](../docs/runbooks/resource-cleanup.md) before deleting resources. The Recovery Services vault must be unprotected and cleared before its resource group can be removed. The cleanup helper defaults to a dry run and requires an explicit destructive flag.
