module "worker" {
  source = "./create_app"

  app_name = "terraform-repro-worker"
  src_path = "src"
  stack = "heroku-20"
  buildpacks = [
    "heroku/ruby",
  ]
  config_vars = {
    FOO = "bar"
  }
  formation = [
    {
      quantity = 1
      size = "Standard-1X"
      type = "worker"
    },
  ]
}
