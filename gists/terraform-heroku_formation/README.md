# repro

Shell needs `HEROKU_EMAIL` and `HEROKU_API_KEY` set.

```bash
terraform init

TF_LOG=DEBUG terraform apply -auto-approve

terraform destroy -auto-approve
```

## The failure

```bash
2022-12-14T21:41:25.944+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 [DEBUG] Size: Standard-1X: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.944+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 [DEBUG] Quantity: 1: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.944+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 [DEBUG] Updating 0c0b1941-7aef-48b3-b52e-863051aa642f formation...: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.944+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 [DEBUG] Formation type: worker: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.944+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 PATCH /apps/0c0b1941-7aef-48b3-b52e-863051aa642f/formation/worker HTTP/1.1: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.944+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 Host: api.heroku.com: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.945+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 User-Agent: heroku/v5 (darwin; amd64) terraform-provider-heroku/dev: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.945+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 Content-Length: 35: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.945+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 Accept: application/vnd.heroku+json; version=3: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.945+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 Authorization: [redacted]: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.945+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 Content-Type: application/json: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.945+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 Request-Id: 53b4ae57-6355-439c-8b17-5a20c2a3afd8: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.945+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 Accept-Encoding: gzip: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.945+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:25.945+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:25 {"quantity":1,"size":"Standard-1X"}: timestamp=2022-12-14T21:41:25.944+0100
2022-12-14T21:41:26.169+0100 [INFO]  provider.terraform-provider-heroku_v5.1.9: 2022/12/14 21:41:26 HTTP/2.0 422 Unprocessable Entity
Cache-Control: private, no-cache
Content-Type: application/json
Date: Wed, 14 Dec 2022 20:41:26 GMT
Etag: "fbd82395e4bfb78e44449a54760f5fb8"
Last-Modified: Wed, 14 Dec 2022 20:41:18 GMT
Oauth-Scope: global
Oauth-Scope-Accepted: global write write-protected
Ratelimit-Multiplier: 1
Ratelimit-Remaining: 4497
Request-Id: 554515b9-4ebc-4611-9bda-c26b20b86127,53b4ae57-6355-439c-8b17-5a20c2a3afd8,e9d62ba1-16b2-8a38-0247-64e157b897ab,eedb9d9c-0be7-0e82-9563-2e5d62ac9a76
Traceparent: 00-1b35a1944c4c7259e45107eb3984e56e-03e78d2caa07ec0d-01
Vary: Authorization,Accept-Encoding
Via: 1.1 spaces-router (e13668ca8eb7), 2.0 spaces-router (e13668ca8eb7)
X-Content-Type-Options: nosniff
X-Runtime: 0.112139935

{"id":"invalid_params","message":"Cannot use the following dyno types in the same app: Basic and Standard-1X"}: timestamp=2022-12-14T21:41:26.169+0100
2022-12-14T21:41:26.170+0100 [ERROR] provider.terraform-provider-heroku_v5.1.9: Response contains error diagnostic: tf_proto_version=5.3 tf_provider_addr=provider @module=sdk.proto diagnostic_detail= diagnostic_severity=ERROR diagnostic_summary="Patch "https://api.heroku.com/apps/0c0b1941-7aef-48b3-b52e-863051aa642f/formation/worker": Cannot use the following dyno types in the same app: Basic and Standard-1X" @caller=/home/runner/work/terraform-provider-heroku/terraform-provider-heroku/vendor/github.com/hashicorp/terraform-plugin-go/tfprotov5/internal/diag/diagnostics.go:55 tf_req_id=3c33f83a-1857-564e-0bfd-ef7195798a51 tf_resource_type=heroku_formation tf_rpc=ApplyResourceChange timestamp=2022-12-14T21:41:26.169+0100
2022-12-14T21:41:26.193+0100 [ERROR] vertex "module.worker.heroku_formation.formation[\"0\"]" error: Patch "https://api.heroku.com/apps/0c0b1941-7aef-48b3-b52e-863051aa642f/formation/worker": Cannot use the following dyno types in the same app: Basic and Standard-1X
╷
│ Error: Patch "https://api.heroku.com/apps/0c0b1941-7aef-48b3-b52e-863051aa642f/formation/worker": Cannot use the following dyno types in the same app: Basic and Standard-1X
│
│   with module.worker.heroku_formation.formation["0"],
│   on create_app/create_app.tf line 34, in resource "heroku_formation" "formation":
│   34: resource "heroku_formation" "formation" {
│
╵
2022-12-14T21:41:26.236+0100 [DEBUG] provider.stdio: received EOF, stopping recv loop: err="rpc error: code = Unavailable desc = error reading from server: EOF"
2022-12-14T21:41:26.240+0100 [DEBUG] provider: plugin process exited: path=.terraform/providers/registry.terraform.io/heroku/heroku/5.1.9/darwin_amd64/terraform-provider-heroku_v5.1.9 pid=85909
2022-12-14T21:41:26.240+0100 [DEBUG] provider: plugin exited
```

The "free" web dyno makes it impossible to scale the worker to Standard dyno:

```bash
$ heroku ps --app terraform-repro-worker
 ▸    Starting November 28th, 2022, free Heroku Dynos will no longer be available. To keep your apps running, upgrade to paid dynos. Learn more in our blog (https://blog.heroku.com/next-chapter).
=== web (Basic): bundle exec rackup config.ru -p ${PORT:-5000} (1)
web.1: crashed 2022/12/14 21:41:26 +0100 (~ 4m ago)
```
