#!/usr/bin/env bash
set -Eeuo pipefail

# Validates the current Azure context and deploys only the version-controlled
# Linux Data Collection Rule. It does not create the full lab environment.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$REPO_ROOT/infrastructure/env/project.env"

: "${SUBSCRIPTION_ID:?Set SUBSCRIPTION_ID to the intended Azure subscription ID.}"
: "${LOG_ANALYTICS_WORKSPACE_ID:?Set LOG_ANALYTICS_WORKSPACE_ID to the full workspace resource ID.}"

DCR_NAME="${DCR_NAME:-dcr-contoso-vm-dev}"
COST_CENTER="${COST_CENTER:-PortfolioLab}"
MANAGED_BY="${MANAGED_BY:-AzureCLI-Bicep}"
TEMPLATE="$REPO_ROOT/infrastructure/monitoring/dcr-linux-monitoring.bicep"

command -v az >/dev/null 2>&1 || { echo "Azure CLI is required." >&2; exit 1; }
az account set --subscription "$SUBSCRIPTION_ID"
CURRENT_SUBSCRIPTION="$(az account show --query id --output tsv)"
[[ "$CURRENT_SUBSCRIPTION" == "$SUBSCRIPTION_ID" ]] || { echo "Subscription context mismatch." >&2; exit 1; }

az group show --name "$MANAGEMENT_RG" >/dev/null
az bicep build --file "$TEMPLATE" --stdout >/dev/null

echo "Running deployment what-if..."
az deployment group what-if   --resource-group "$MANAGEMENT_RG"   --template-file "$TEMPLATE"   --parameters     dcrName="$DCR_NAME"     location="$LOCATION"     logAnalyticsWorkspaceResourceId="$LOG_ANALYTICS_WORKSPACE_ID"     project="$PROJECT"     environment="Development"     owner="$OWNER"     costCenter="$COST_CENTER"     expirationDate="$EXPIRATION_DATE"     managedBy="$MANAGED_BY"

read -r -p "Deploy/update the DCR shown above? Type DEPLOY to continue: " confirmation
[[ "$confirmation" == "DEPLOY" ]] || { echo "Deployment cancelled."; exit 0; }

az deployment group create   --name "dcr-deployment-$(date -u +%Y%m%d%H%M%S)"   --resource-group "$MANAGEMENT_RG"   --template-file "$TEMPLATE"   --parameters     dcrName="$DCR_NAME"     location="$LOCATION"     logAnalyticsWorkspaceResourceId="$LOG_ANALYTICS_WORKSPACE_ID"     project="$PROJECT"     environment="Development"     owner="$OWNER"     costCenter="$COST_CENTER"     expirationDate="$EXPIRATION_DATE"     managedBy="$MANAGED_BY"   --output table
