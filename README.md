# Rancher UI Extension Workflow

This repository contains reusable workflows for building and publishing extensions.

## Extension Chart Workflow

To build the charts needed to provide a Helm repository, use the workflow found in `.github/workflows/build-extension-chart.yml`. When published you will be able to target the Github repository as a Helm repository, which will serve the charts for installation within the Rancher Dashboard.

### Extension Chart Inputs

| Property | Required | Description |
| -------- | :---: | -----------------|
| `permissions` | `true` | This gives the workflow permissions to checkout, build, and push to the repository or registry. |
| `target_branch` | `true` | The Github branch target for the extension build assets |



### Example usage

```yml
...
jobs:
  build-extension-chart:
    uses: jordojordo/ui-chart-workflow/.github/workflows/build-extension-chart.yml@main
    permissions:
      actions: write
      contents: write
      deployments: write
      id-token: write
      packages: write
      pages: write
      pull-requests: write
    with:
      target_branch: gh-pages
```

## Extension Catalog Image Workflow

To build an Extension Catalog Image (ECI) for air-gapped/private repositories, use the workflow found in `.github/workflows/build-extension-container.yml`. This will build and push the container image push to the specified registry.

### Extension Catalog Image Inputs

| Property | Required | Description |
| -------- | :---: | -----------------|
| `permissions` | `true` | This gives the workflow permissions to checkout, build, and push to the repository or registry. |
| `registry_target` | `true` | The container registry to publish the catalog image |
| `registry_user` | `true` | The username connected to the container registry |
| `registry_token` | `true` | The password or token used to authenticate with the registry |

### Example Usage

```yml
...
jobs:
  build-extension-chart:
    uses: jordojordo/ui-chart-workflow/.github/workflows/build-extension-container.yml@main
    permissions:
      actions: write
      contents: write
      deployments: write
      id-token: write
      packages: write
      pages: write
      pull-requests: write
    with:
      registry_target: ghcr.io
      registry_user: ${{ github.actor }}
    secrets: 
      registry_token: ${{ secrets.GITHUB_TOKEN }}
```