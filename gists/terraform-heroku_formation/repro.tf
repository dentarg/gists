locals {
  apps = [
    {
      app    = "terraform-issue-repro-tut"
      stack  = "heroku-20"
      formation = [
        {
          quantity = 1
          size = "standard-2x"
          type = "worker"
        },
      ]
      buildpacks = [
        "heroku/ruby",
      ]
    }
  ]
}

module "apps" {
  for_each   = {for i, v in local.apps:  i => v}
  source     = "./create_app"

  app_name   = each.value.app
  buildpacks = each.value.buildpacks
  formation  = each.value.formation
  stack      = each.value.stack
}
