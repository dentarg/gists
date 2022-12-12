# repro

Shell needs `HEROKU_EMAIL` and `HEROKU_API_KEY` set.

```bash
terraform init

terraform apply -auto-approve

terraform destroy -auto-approve
```

## Not the failure I expected

```bash
$ dotenv terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.apps["0"].heroku_app.app will be created
  + resource "heroku_app" "app" {
      + acm                   = (known after apply)
      + all_config_vars       = (sensitive value)
      + buildpacks            = [
          + "heroku/ruby",
        ]
      + config_vars           = (known after apply)
      + git_url               = (known after apply)
      + heroku_hostname       = (known after apply)
      + id                    = (known after apply)
      + internal_routing      = (known after apply)
      + name                  = "terraform-issue-repro-tut"
      + region                = "eu"
      + sensitive_config_vars = (sensitive value)
      + stack                 = "heroku-20"
      + uuid                  = (known after apply)
      + web_url               = (known after apply)
    }

  # module.apps["0"].heroku_build.build will be created
  + resource "heroku_build" "build" {
      + app_id            = (known after apply)
      + buildpacks        = (known after apply)
      + id                = (known after apply)
      + local_checksum    = "SHA256:ddf72591d70546a3fcad0ed4a5e7481c6fcb449d79f4926163144cec34987f7a"
      + output_stream_url = (known after apply)
      + release_id        = (known after apply)
      + slug_id           = (known after apply)
      + stack             = (known after apply)
      + status            = (known after apply)
      + user              = (known after apply)
      + uuid              = (known after apply)

      + source {
          + checksum = (known after apply)
          + path     = "src"
        }
    }

  # module.apps["0"].heroku_formation.formation["0"] will be created
  + resource "heroku_formation" "formation" {
      + app_id   = (known after apply)
      + id       = (known after apply)
      + quantity = 0
      + size     = "Standard-2X"
      + type     = "web"
    }

  # module.apps["0"].heroku_formation.formation["1"] will be created
  + resource "heroku_formation" "formation" {
      + app_id   = (known after apply)
      + id       = (known after apply)
      + quantity = 1
      + size     = "Standard-2X"
      + type     = "worker"
    }

Plan: 4 to add, 0 to change, 0 to destroy.
module.apps["0"].heroku_app.app: Creating...
module.apps["0"].heroku_app.app: Still creating... [10s elapsed]
module.apps["0"].heroku_app.app: Creation complete after 12s [id=3d835caa-2709-4ce4-afea-d10a302fc491]
module.apps["0"].heroku_build.build: Creating...
module.apps["0"].heroku_build.build: Still creating... [10s elapsed]
module.apps["0"].heroku_build.build: Still creating... [20s elapsed]
module.apps["0"].heroku_build.build: Creation complete after 27s [id=a1e8be74-b890-4bf1-a0b1-bffc1b3e23ea]
module.apps["0"].heroku_formation.formation["1"]: Creating...
module.apps["0"].heroku_formation.formation["0"]: Creating...
module.apps["0"].heroku_formation.formation["1"]: Creation complete after 1s [id=5955a70d-c173-4516-946c-b78e312142f8]
╷
│ Error: Patch "https://api.heroku.com/apps/3d835caa-2709-4ce4-afea-d10a302fc491/formation/web": Couldn't find that process type (web).
│
│   with module.apps["0"].heroku_formation.formation["0"],
│   on create_app/create_app.tf line 31, in resource "heroku_formation" "formation":
│   31: resource "heroku_formation" "formation" {
│
╵
```
