#!/bin/bash
#File name cert-manager-installation.sh
# Function to display usage information
usage() {
    echo "Usage: $0 [apply|delete]"
    exit 1
}

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
    usage
fi

# Fetch the latest release version from GitHub API
latest_version=$(curl -s https://api.github.com/repos/cert-manager/cert-manager/releases/latest | grep "tag_name" | cut -d'"' -f4)

if [ -z "$latest_version" ]; then
  echo "Failed to retrieve latest release version."
  exit 1
fi

echo "Latest cert-manager release version: $latest_version"

# Apply or delete the YAML file using kubectl based on the provided argument
if [ "$1" == "apply" ]; then
    kubectl apply -f "https://github.com/cert-manager/cert-manager/releases/download/$latest_version/cert-manager.yaml"
    echo "Cert-manager applied successfully."
elif [ "$1" == "delete" ]; then
    kubectl delete -f "https://github.com/cert-manager/cert-manager/releases/download/$latest_version/cert-manager.yaml"
    echo "Cert-manager deleted successfully."
else
    usage
fi

