# Render Terraform

A simple open source Terraform configuration for provisioning a Render web service on Render Cloud.

This repository is designed to help developers manage Render infrastructure as code using Terraform, making deployments repeatable, version-controlled, and easy to share across environments.

## What this project provisions

The configuration defines a Render web service using the official Render Terraform provider:

- service name
- deployment region
- Render plan
- Docker image source and tag
- service configuration via Terraform variables

## Repository structure

```text
.
├── .gitignore
├── README.md
└── terraform/
    ├── main.tf
    ├── variables.tf
    └── schema.json
```

## Prerequisites

Before using this project, make sure you have:

- Terraform installed locally
- A Render account
- A Render API key
- A Docker image already available in a registry that Render can pull from

## Required Terraform provider

This project uses the Render provider:

```hcl
terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "~> 1.0"
    }
  }
}
```

## Configuration

Set the required input values in a `terraform.tfvars` file or provide them as environment variables / CLI arguments.

Example:

```hcl
image_url = "docker.io/your-org/your-app"
tag = "latest"
name = "my-render-service"
region = "oregon"
plan = "starter"
RENDER_API_KEY = "your_render_api_key"
```

## Render API key

The project expects a Render API key. You can set it in your shell before running Terraform:

```bash
export RENDER_API_KEY="your_render_api_key"
```

You may also pass it in via Terraform variables, depending on your workflow.

## Usage

From the `terraform/` directory:

```bash
terraform init
terraform plan
terraform apply
```

To destroy the provisioned service:

```bash
terraform destroy
```

## Example service definition

The main Terraform resource is:

```hcl
resource "render_web_service" "web" {
  name   = var.name
  region = var.region
  plan   = var.plan

  runtime_source = {
    image = {
      image_url = var.image_url
      tag       = var.tag
    }
  }
}
```

This creates a Render web service that runs your container image.

## Notes

- The provider is configured to work with Render Cloud.
- The repository is intentionally minimal and easy to extend.
- You can add additional Render resources such as databases, custom domains, environment variables, and service settings as your infrastructure grows.
- On free-tier Render accounts, maintenance mode is not supported for switching state and may default to enabled. This can cause Terraform drift or apply errors when trying to manage it explicitly. To avoid this, the configuration currently ignores changes to `maintenance_mode` in the lifecycle block so the service can still be managed without failing on free-tier restrictions.

> Important: In a free-tier Render account, `maintenance_mode` is effectively restricted and may remain on by default. The lifecycle ignore block is used as a workaround so Terraform does not try to force a state change that Render rejects for free-tier services.

## Why use this repo

This repository is useful when you want to:

- manage Render deployments with Terraform
- keep infrastructure changes under version control
- reproduce environments reliably
- collaborate on deployment configuration with your team

## License

This project is open source and released under the MIT License unless you choose a different license for your fork.

## Contributing

Contributions are welcome. If you want to improve this project, feel free to:

1. fork the repository
2. create a feature branch
3. make your changes
4. submit a pull request

## Disclaimer

This project is a starter template for provisioning Render infrastructure with Terraform. You should review Render pricing, service limits, and provider documentation before using it in production.
