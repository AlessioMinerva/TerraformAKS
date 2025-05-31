#!/bin/bash

# Read input (JSON) from stdin and parse 'location'
read -r INPUT
LOCATION=$(echo "$INPUT" | jq -r .location)

# Fetch VM sizes for the provided location and sort them by cores
VM_SIZES=$(az vm list-sizes --location "$LOCATION" --query "sort_by([].{name:name, cores:numberOfCores}, &cores)[].name" -o tsv | paste -sd "," -)

# Return result as JSON string map
echo "{\"vm_sizes\": \"${VM_SIZES}\"}"
