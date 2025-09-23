# `send_file`

```shell
$ curl -i localhost:9090
HTTP/1.1 404 Not Found
content-type: text/plain;charset=utf-8
x-content-type-options: nosniff
content-length: 0


$ echo "foo bar" > /tmp/foo

$ curl -i localhost:9090
HTTP/1.1 200 OK
content-type: text/plain;charset=utf-8
last-modified: Tue, 23 Sep 2025 14:35:15 GMT
x-content-type-options: nosniff
content-length: 8

foo bar
```
