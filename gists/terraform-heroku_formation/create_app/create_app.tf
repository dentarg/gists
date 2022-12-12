terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = ">= 5.1.9"
    }
  }
}

# input parameters of the module
variable "buildpacks" {}
variable "formation" {}
variable "stack" {}
variable "app_name" {}

resource "heroku_app" "app" {
  name       = var.app_name
  region     = "eu"
  stack      = var.stack
  buildpacks = var.buildpacks
}

resource "heroku_build" "build" {
  app_id = heroku_app.app.id

  source {
    path = "src"
  }
}

resource "heroku_formation" "formation" {
  for_each   = {for i, v in var.formation:  i => v}

  app_id     = heroku_app.app.id
  quantity   = each.value.quantity
  size       = each.value.size
  type       = each.value.type
  depends_on = [heroku_build.build]
}
