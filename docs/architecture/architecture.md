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

## Cost Decisions

- Resources are deployed only for testing and documentation.
- A small Linux VM size will be selected.
- VM auto-shutdown will be enabled.
- Azure Bastion will be used only temporarily or through the free
  Developer SKU when supported.
- Resources will be deleted after validation and screenshots are complete.