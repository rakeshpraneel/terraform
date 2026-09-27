terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "~> 1.0"
    }
  }
}

provider "render" {}

resource "render_web_service" "web" {
  name   = var.name
  region = var.region
  plan   = var.plan

  lifecycle {
    ignore_changes = [
      maintenance_mode
    ]
  }

  // turning this off since it is not supported in free tier
  //maintenance_mode = {
  //  enabled = false
  //}


  runtime_source = {
    image = {
      image_url = var.image_url
      tag       = var.tag
    }
  }
}