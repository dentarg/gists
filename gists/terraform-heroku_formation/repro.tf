module "app0" {
  source = "./create_app"

  app_name = "terraform-repro-web"
  src_path = "web_src"
  stack = "heroku-20"
  buildpacks = [
    "heroku/ruby",
  ]
  formation = [
    {
      quantity = 1
      size = "Basic"
      type = "web"
    },
  ]
}

module "app1" {
  source = "./create_app"
  depends_on = [module.app0]

  app_name = "terraform-repro-worker"
  src_path = "src"
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
