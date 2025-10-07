## `benchmark.rb` results

The server: `{version: "PostgreSQL 17.6 (Homebrew) on aarch64-apple-darwin24.4.0, compiled by Apple clang version 17.0.0 (clang-1700.0.13.3), 64-bit"}`

without `sequel_pg`, two runs

```
$ ruby benchmark.rb
...

  0.431798   0.029493   0.461291 (  0.490088)
  0.041639   0.002767   0.044406 (  0.059458)

  0.425887   0.029986   0.455873 (  0.487248)
  0.040672   0.002971   0.043643 (  0.066722)
```

with `sequel_pg`, two runs

```
$ ruby benchmark.rb sequel_pg
...

  0.229492   0.028869   0.258361 (  0.288953)
  0.022101   0.002286   0.024387 (  0.032492)

  0.229227   0.030416   0.259643 (  0.288209)
  0.022379   0.002329   0.024708 (  0.032330)
```
