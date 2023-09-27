# Policy Composition

This repo demonstrates a mechanism to create hierarchical [Enterprise
Contract](https://enterprisecontract.dev/) policy configurations.

The general idea is to leverage [Kustomize](https://kustomize.io/) to specify derivations of a base
policy configuration.

The output are multiple policy configurations meant to be used individually while making it easy to
manage common attributes between them. For example, enforcing that policies "inherit" common
attributes defined in a single place, but also allowing custom changes as needed.

## Layout

The [src](./src) directory contains subdirectories for each expected policy configuration. Some of
them are self-contained, e.g. [redhat](./src/redhat), while others derive from others, e.g.
[product-one](./src/product-one).

The [policies](./policies) directory holds the generated policy configurations. These are meant to
be used as is when using the Enteprise Contract. They should not be updated manually. They are
updated by running `make` from the root of this repository.

The [Makefile](./Makefile) is a convenient way to invoke the [generate.sh](./scripts/generate.sh)
script. This script iterates through all the directories under [src](./src), generates policy
configurations accordingly, and stores the output under the [policies](./policies) directory.

## Formats

Due to [enterprise-contract/ec-cli#1040](https://github.com/enterprise-contract/ec-cli/issues/1040),
the [src](./src) files and the [policies](./policies) files have a different format.

The files in [src](./src) are
[EnterpriseContractConfig](https://enterprisecontract.dev/docs/ecc/main/#_as_a_kubernetes_custom_resource)
custom kubernetes resources. This is needed because `kustomize` only works with kubernetes
resources.

The files in [policies](./policies) are in the non-kubernetes policy configuration format because
of [enterprise-contract/ec-cli#1040](https://github.com/enterprise-contract/ec-cli/issues/1040).
Once that issue is addressed, both directories could use the same format.
