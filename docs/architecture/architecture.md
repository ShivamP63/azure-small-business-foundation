# Architecture Design

## Environment Type

Simplified small-business Azure foundation for a development workload.

## Region

Canada Central

## Resource Organization

Resources are separated into four resource groups:

- Networking
- Workload
- Security
- Management

This separation allows resources with different purposes and lifecycles
to be managed independently.

## Network Design

The virtual network uses the address space `10.20.0.0/16`.

| Subnet | CIDR | Purpose |
|---|---|---|
| snet-management | 10.20.1.0/24 | Management connectivity |
| snet-workload | 10.20.2.0/24 | Application virtual machines |
| snet-private-endpoints | 10.20.3.0/24 | Future private endpoints |

The remaining address space is reserved for future growth.

## Security Decisions

- The application virtual machine will not receive a public IP address.
- SSH will not be exposed directly to the internet.
- The workload subnet is protected by a network security group.
- SSH is allowed only from the management subnet.
- Application secrets will be stored in Azure Key Vault.
- Monitoring data will be sent to a central Log Analytics workspace.

### Administrative Access

The virtual machine is deployed without a Public IP address.

Administrative operations are demonstrated using Azure Run Command.

For production deployments, Azure Bastion or a private management network (VPN/ExpressRoute) would provide interactive SSH access while keeping the VM private.

## Storage Design

The workload uses an Azure Storage Account (StorageV2) for application files.

Security decisions:

- HTTPS required
- Minimum TLS 1.2
- Anonymous blob access disabled
- Private blob container
- Microsoft Entra ID authentication
- Azure RBAC used for blob access
- Storage account keys intentionally not used for blob operations

Production improvements:

- Private Endpoint
- Storage Firewall
- Disable Shared Key access after validating Managed Identity and Microsoft Entra authentication.

## Secrets Management Design

Application configuration values are stored in Azure Key Vault rather than directly on the virtual machine or in source control.

The vault uses Azure RBAC instead of legacy vault access policies.

### Role Separation

- Administrators use the `Key Vault Secrets Officer` role to manage secrets.
- The application VM uses the `Key Vault Secrets User` role to read secrets.
- Both assignments are scoped to the individual Key Vault.

### Managed Identity Flow

1. The VM requests an OAuth token from Azure Instance Metadata Service.
2. Microsoft Entra ID issues a token representing the VM's managed identity.
3. The VM sends the token to Azure Key Vault.
4. Key Vault evaluates the VM's RBAC assignment.
5. The authorized secret is returned without stored credentials.

### Security Decisions

- System-assigned managed identity avoids credential storage.
- Least-privilege RBAC separates administration from workload access.
- Purge protection reduces the risk of permanent secret deletion.
- Secret values and tokens are excluded from screenshots and source control.
- A private endpoint and restricted network access are documented as production improvements.

## Cost Decisions

- Resources are deployed only for testing and documentation.
- A small Linux VM size will be selected.
- VM auto-shutdown will be enabled.
- Azure Bastion will be used only temporarily or through the free
  Developer SKU when supported.
- Resources will be deleted after validation and screenshots are complete.


Linux VM
     │
Azure Monitor Agent
     │
Data Collection Rule
     │
Log Analytics Workspace
     │
 ┌──────────────┐
 │              │
Metric Alert    Scheduled Query Alert
 │              │
 └──────┬───────┘
        │
 Action Group
        │
 Email Notifications