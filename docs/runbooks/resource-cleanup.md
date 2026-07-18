# Resource Cleanup Runbook

## Purpose

Safely remove the Azure Small-Business Foundation lab after evidence has been collected, while avoiding orphaned resources, backup-vault deletion failures, and unnecessary charges.

## Safety Rules

- Confirm screenshots, documentation, and Git commits are complete before deletion.
- Verify the active subscription with `az account show`; never rely on a remembered context.
- Do not paste secret values or access tokens into terminal logs.
- Start with inventory and dry-run commands.
- Treat Recovery Services vault cleanup as a separate prerequisite.
- Keep the network resource group until dependent NICs and workloads are removed.

## 1. Establish Context

```bash
export SUBSCRIPTION_ID='<subscription-id>'
az account set --subscription "$SUBSCRIPTION_ID"
az account show --query '{Name:name,Subscription:id,Tenant:tenantId}' --output table
```

## 2. Inventory Project Resources

```bash
for rg in   rg-contoso-workload-dev   rg-contoso-security-dev   rg-contoso-management-dev   rg-contoso-network-dev; do
  echo "=== $rg ==="
  az resource list --resource-group "$rg" --query '[].{Name:name,Type:type,Location:location}' --output table
done
```

Also review Cost Management, unattached disks, public IPs, snapshots, and any resources carrying the project tag.

## 3. Stop the VM

```bash
az vm deallocate   --resource-group rg-contoso-workload-dev   --name vm-contoso-app-dev-01
```

Deallocation stops compute charges but does not remove disks, monitoring ingestion, backup storage, or other resources.

## 4. Remove Backup Protection

A protected item prevents straightforward vault deletion. Confirm the item first:

```bash
az backup item list   --resource-group rg-contoso-management-dev   --vault-name rsv-contoso-backup-dev   --backup-management-type AzureIaasVM   --workload-type VM   --output table
```

Disable protection and delete backup data only after confirming the correct VM and vault:

```bash
az backup protection disable   --resource-group rg-contoso-management-dev   --vault-name rsv-contoso-backup-dev   --container-name 'iaasvmcontainerv2;rg-contoso-workload-dev;vm-contoso-app-dev-01'   --item-name vm-contoso-app-dev-01   --backup-management-type AzureIaasVM   --delete-backup-data true   --yes
```

Recheck protected items and backup jobs. Soft-deleted items may require additional portal or CLI cleanup before the vault can be deleted.

## 5. Delete Resource Groups in Dependency Order

Recommended order:

1. `rg-contoso-workload-dev`
2. `rg-contoso-security-dev`
3. `rg-contoso-management-dev`
4. `rg-contoso-network-dev`

Preview existence first:

```bash
az group exists --name rg-contoso-workload-dev
```

Delete one group at a time and wait for completion or verify asynchronously before continuing:

```bash
az group delete --name rg-contoso-workload-dev --yes --no-wait
```

Do not delete the network group first because the workload NIC references its subnet.

## 6. Verify Deletion

```bash
az group list   --query "[?starts_with(name, 'rg-contoso-')].[name,location,properties.provisioningState]"   --output table

az disk list --query "[?managedBy==null].[name,resourceGroup,diskState]" --output table
az network public-ip list --query "[].{Name:name,ResourceGroup:resourceGroup,IP:ipAddress}" --output table
```

Check the Azure portal for:

- Remaining Recovery Services vaults or soft-deleted backup items
- Unattached managed disks or snapshots
- Public IP addresses
- Log Analytics workspaces still ingesting data
- Action groups and alert rules
- Key Vaults in a soft-deleted state
- Unexpected project-tagged resources

## 7. Cost Verification

Review Cost Analysis after Azure has processed deletions. Charges may appear with a delay. Confirm that no compute, backup, storage, Log Analytics, or public IP resources remain active.

## Rollback / Stop Conditions

Stop cleanup immediately if:

- The active subscription is not the intended lab subscription.
- A resource group contains resources unrelated to this project.
- The backup item or VM name does not match the expected environment.
- Required evidence or configuration has not been committed.

The helper script at [`scripts/cleanup.sh`](../../scripts/cleanup.sh) performs inventory by default and requires `--execute` before destructive group deletion.
