#!/usr/bin/env bash
set -euo pipefail

find src/ -name kustomization.yaml | while read fname; do
    echo "Processing ${fname} ..."
    src="$(dirname "${fname}")"
    product="$(basename "${src}")"

    dst="policies/${product}"
    policy="${dst}/policy.yaml"
    mkdir -p "${dst}"
    kustomize build "${src}" | yq '.spec' > "${policy}"
    echo -e "\tUpdated ${policy}"
done

