#!/bin/bash

set -euo pipefail

# Variables
PROJECT_NAME="TerraformAKS"
LOCATION="UKSouth"
CONTAINER_NAME="tfstate"

# Loop over .tfvars files and create storage account and container
for file in *.tfvars; do
  ENVIRONMENT="${file%%.tfvars}"  # Strip .tfvars
  RESOURCE_GROUP_NAME="${ENVIRONMENT}-${PROJECT_NAME}"
  STORAGE_ACCOUNT_NAME=$(echo "${ENVIRONMENT}tfbackend${PROJECT_NAME}" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9') # cut -c1-24 can be added to enforce the name lengh but it will give inconistet naming

  # Check name lengh(max 24 chars for Azure storage account)
  if [ ${#STORAGE_ACCOUNT_NAME} -gt 24 ]; then
    echo "ERROR: Storage account name '$STORAGE_ACCOUNT_NAME' exceeds 24 characters."
    echo "Please shorten ENVIRONMENT or PROJECT_NAME to fit naming limits."
    exit 1
  fi

  echo "Processing environment: $ENVIRONMENT"
  echo "Resource group name: $RESOURCE_GROUP_NAME"
  echo "Storage Account: $STORAGE_ACCOUNT_NAME"

  # Create storage account
  az group create \
    --name "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION"

  # Create storage account
  az storage account create \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --name "$STORAGE_ACCOUNT_NAME" \
    --location "$LOCATION" \
    --sku Standard_LRS \
    --encryption-services blob

  # Create blob container
  az storage container create \
    --name "$CONTAINER_NAME" \
    --account-name "$STORAGE_ACCOUNT_NAME"
done

echo "All resources created successfully."
