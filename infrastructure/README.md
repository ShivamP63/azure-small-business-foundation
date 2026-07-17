# Infrastructure Deployment Notes

## Linux VM provisioning

The Linux virtual machine uses a pre-created network interface connected
to the `snet-workload` subnet.

The virtual network is located in `rg-contoso-network-dev`, while the
network interface and virtual machine are located in
`rg-contoso-workload-dev`.

Because the subnet is located in a different resource group from the
network interface, the NIC deployment references the subnet by its full
Azure resource ID.

The VM has:

- No public IP address
- SSH-key authentication
- A system-assigned managed identity
- A Standard LRS operating-system disk
- Nginx installed through cloud-init
- Auto-shutdown enabled

The VM is not directly reachable from the public internet.
Azure Run Command was used for initial workload validation.

Interactive administrative access will be implemented separately using
Azure Bastion.

## Azure Storage

### Storage Account

| Property | Value |
|----------|-------|
| Resource Group | rg-contoso-workload-dev |
| Region | Canada Central |
| Kind | StorageV2 |
| SKU | Standard_LRS |
| HTTPS Only | Enabled |
| Minimum TLS | TLS 1.2 |
| Blob Public Access | Disabled |
| Public Network Access | Enabled |
| Shared Key Access | Enabled (temporary) |

### Blob Container

Container Name:

app-files

Authentication:

- Microsoft Entra ID
- Azure RBAC
- Storage Blob Data Contributor

A private blob container was created and validated by uploading a sample file using `--auth-mode login` without relying on storage account keys.
