## Project Status

Completed:

- Repository structure
- Cost budget
- Resource groups and tagging
- Virtual network and subnets
- Workload network security group
- Private Linux virtual machine
- System-assigned managed identity
- Automated Nginx installation
- Boot diagnostics
- VM auto-shutdown

Next phase:

- Secure administrative access using Azure Bastion
- Storage account
- Azure Key Vault
- Managed identity authorization
- Log Analytics and Azure Monitor
- Alerts and backup

## Virtual Machine Security

The Linux virtual machine was deployed without a public IP address.
The VM uses SSH-key authentication rather than password authentication.

Its network interface is connected to the workload subnet, which is
protected by a subnet-level network security group. Direct SSH access
from the internet is not permitted.

A system-assigned managed identity is enabled so that the VM can later
access Azure services without storing Azure credentials locally.

Nginx was installed automatically using cloud-init, and the deployment
was validated using Azure Run Command.