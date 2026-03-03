# AI Agents Guidelines

This document provides instructions for AI Agents working with this Terraform module template.

## Guidelines

- **Avoid to modify**: `locals-vars.tf`, `variables.tf`, and any files originating from the cloud provider boilerplate (e.g., `aws.tf`, `google.tf`, `azurerm.tf`, `variables-azurerm.tf`, `locals.tf`) in `.cloudopsworks/boilerplate/` (except `versions.tf`).
- **Use variables-module.tf**:
  - Rename the word `module` in `variables-module.tf` with a proper subname depending on the purpose of this module.
  - The subname must be no more than 12 chars (e.g., `variables-vpc.tf`).
- **Initialization**:
  - This template must be initialized on the target cloud provider using `Makefile`.
  - For AWS: `make init/aws`
  - For GCP: `make init/gcp`
  - For Azure: `make init/azurerm`
  - The initialization process for each cloud will copy its boilerplate files to the root module.
  - If a `versions.tf` file exists (e.g., from `.cloudopsworks/boilerplate/aws`, `gcp`, or `azurerm`), the module is already initialized and under development.
  - You can check the current provider in `.cloudopsworks/.provider`.
  - You can modify `versions.tf` to include additional providers to help with the resolution of your task.
