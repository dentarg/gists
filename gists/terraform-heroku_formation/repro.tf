module "app0" {
  source = "./create_app"

  app_name = "terraform-issue-repro-app0"
  stack = "heroku-20"
  buildpacks = [
    "heroku/ruby",
  ]
  formation = [
    {
      quantity = 1
      size = "Basic"
      type = "worker"
    },
  ]
}

module "app1" {
  source = "./create_app"
  depends_on = [module.app0]

  app_name = "terraform-issue-repro-app1"
  stack = "heroku-20"
  buildpacks = [
    "heroku/ruby",
  ]
  formation = [
    {
      quantity = 1
      size = "standard-2x"
      type = "worker"
    },
  ]
}
