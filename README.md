# Azure Small-Business Foundation

## Overview

This project demonstrates the design and deployment of a secure,
monitored, and cost-conscious Azure environment for a fictional small
business.

The environment includes Azure networking, network security groups,
a Linux virtual machine, secure administrative access, Azure Key Vault,
a storage account, centralized monitoring, alerting, and backup.

## Business Scenario

Contoso Retail Services is moving an internal administration workload
to Microsoft Azure. The company needs a basic cloud foundation that is
secure, organized, monitored, recoverable, and affordable.

## Project Objectives

- Organize Azure resources using resource groups, naming standards, and tags
- Segment the network using multiple subnets
- Control traffic using network security groups
- Deploy a Linux virtual machine without exposing SSH directly to the internet
- Store secrets securely in Azure Key Vault
- Centralize logs in a Log Analytics workspace
- Configure monitoring and alerts
- Protect the virtual machine using Azure Backup
- Document deployment, validation, troubleshooting, and cleanup procedures

## Technologies

- Microsoft Azure
- Azure Virtual Network
- Network Security Groups
- Azure Virtual Machines
- Azure Bastion
- Azure Storage
- Azure Key Vault
- Azure Monitor
- Log Analytics
- Azure Monitor Agent
- Recovery Services Vault
- Azure CLI
- Git and GitHub

## Architecture

Architecture diagram will be added after the initial environment is deployed.

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

## 📸 Deployment Screenshots

A complete visual walkthrough of every deployment phase is available in:

- [Screenshot Gallery](docs/screenshots/README.md)

## Cost Management

This environment is intended as a temporary portfolio lab.

Cost controls include:

- Small Linux VM size
- VM auto-shutdown
- Budget alerts
- Temporary use of Azure Bastion
- Short Log Analytics retention where supported
- Complete resource cleanup after testing

## Disclaimer

This is a portfolio and learning project. It represents a simplified
small-business Azure foundation rather than a complete enterprise-scale
Azure landing zone.