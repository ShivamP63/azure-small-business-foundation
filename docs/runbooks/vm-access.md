# VM Access Runbook

## Purpose

This runbook describes how administrators access the application VM securely.

## Design

The VM intentionally does not have:

- Public IP
- Internet-exposed SSH

Administrative access is performed using Azure Run Command for this portfolio project.

## Production Recommendation

For production environments, administrators should use one of:

- Azure Bastion
- Site-to-Site VPN
- Point-to-Site VPN
- ExpressRoute
- A hardened jump host

Direct SSH exposure from the Internet should be avoided.

## Validation

Verify the VM has:

- Private IP address only
- No Public IP
- NSG protecting the workload subnet
