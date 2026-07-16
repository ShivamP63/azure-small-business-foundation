# Resource Cleanup Runbook

## Purpose

This runbook prevents unnecessary Azure charges after the portfolio
demonstration is complete.

## Cost-Control Rules

1. Deploy only one portfolio environment at a time.
2. Enable auto-shutdown immediately after creating a virtual machine.
3. Do not leave a paid Azure Bastion deployment running after testing.
4. Review Cost Analysis after every deployment session.
5. Delete unused public IP addresses, disks, snapshots, and backup data.
6. Remove the complete project environment after screenshots and validation
   evidence have been collected.
7. Confirm that no project resources remain after cleanup.

## Post-Cleanup Verification

- Review the project resource groups
- Check for unattached managed disks
- Check for unused public IP addresses
- Check for active Recovery Services Vault items
- Check for Azure Bastion
- Review Cost Analysis