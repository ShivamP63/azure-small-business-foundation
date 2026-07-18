#!/usr/bin/env bash
set -Eeuo pipefail

# Inventory-only by default. Use --execute after manually removing Azure Backup
# protection and confirming that every listed resource belongs to this lab.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$REPO_ROOT/infrastructure/env/project.env"

EXECUTE=false
[[ "${1:-}" == "--execute" ]] && EXECUTE=true
: "${SUBSCRIPTION_ID:?Set SUBSCRIPTION_ID to the intended Azure subscription ID.}"
command -v az >/dev/null 2>&1 || { echo "Azure CLI is required." >&2; exit 1; }

az account set --subscription "$SUBSCRIPTION_ID"
echo "Active account:"
az account show --query '{Name:name,Subscription:id,Tenant:tenantId}' --output table

RESOURCE_GROUPS=("$WORKLOAD_RG" "$SECURITY_RG" "$MANAGEMENT_RG" "$NETWORK_RG")
for rg in "${RESOURCE_GROUPS[@]}"; do
  echo "=== $rg ==="
  if [[ "$(az group exists --name "$rg")" == "true" ]]; then
    az resource list --resource-group "$rg" --query '[].{Name:name,Type:type,Location:location}' --output table
  else
    echo "Not found"
  fi
done

if [[ "$EXECUTE" != true ]]; then
  echo
  echo "Dry run complete. Review docs/runbooks/resource-cleanup.md."
  echo "After backup protection/data are removed, rerun with --execute."
  exit 0
fi

read -r -p "Type DELETE-CONTOSO-LAB to delete the four resource groups: " confirmation
[[ "$confirmation" == "DELETE-CONTOSO-LAB" ]] || { echo "Cleanup cancelled."; exit 0; }

# Dependency-aware order: workload before network; management after backup cleanup.
for rg in "${RESOURCE_GROUPS[@]}"; do
  if [[ "$(az group exists --name "$rg")" == "true" ]]; then
    echo "Deleting $rg..."
    az group delete --name "$rg" --yes --no-wait
  fi
done

echo "Deletion requests submitted. Re-run without --execute to verify completion."
