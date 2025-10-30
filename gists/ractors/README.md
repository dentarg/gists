# cruby 3.5

### ractor_pool_example

```shell
$ time BUNDLE_GEMFILE=ractor-pool.gemfile bundle exec ruby -v ractor_pool_example.rb 10000
ruby 3.5.0dev (2025-10-30T19:15:09Z master 6707945f0c) +PRISM [arm64-darwin23]
Started RactorPool with size=2
Took 10.193112000823021 seconds
BUNDLE_GEMFILE=ractor-pool.gemfile bundle exec ruby -v ractor_pool_example.rb  16.66s user 0.54s system 165% cpu 10.408 total
```

---

# jruby

### thread_pool_example

```shell
$ BUNDLE_GEMFILE=concurrent-ruby.gemfile bundle exec ruby -v thread_pool_example.rb 10000
jruby 10.0.0.1 (3.4.2) 2025-05-07 79cf1e4aec OpenJDK 64-Bit Server VM 21.0.1+12-LTS on 21.0.1+12-LTS +indy +jit [arm64-darwin]
Started FixedThreadPool with size=2
Took 2.6543787494301796 seconds
```

---

# cruby 3.4

### thread_pool_example

```shell
$ time BUNDLE_GEMFILE=concurrent-ruby.gemfile bundle exec ruby -v thread_pool_example.rb 10000
ruby 3.4.7 (2025-10-08 revision 7a5688e2a2) +PRISM [arm64-darwin23]
Started FixedThreadPool with size=2
Took 12.673082001507282 seconds
BUNDLE_GEMFILE=concurrent-ruby.gemfile bundle exec ruby -v  10000  12.54s user 0.29s system 99% cpu 12.882 total
```

---

# truffleruby

### ractor_pool_example

```shell
$ BUNDLE_GEMFILE=truffleruby.gemfile bundle e ruby -v ractor_pool_example.rb 1
truffleruby 25.1.0-dev-4e9795ff, like ruby 3.3.7, Oracle GraalVM Native [arm64-darwin23]
Started RactorPool with size=2
RactorPool ractor 0 rescued:
TypeError: RubyArray@2acc7468<Array> is not a symbol nor a string
/Users/dentarg/src/ractor-pool/lib/ractor-pool.rb:238:in `__send__'
/Users/dentarg/src/ractor-pool/lib/ractor-pool.rb:238:in `block (3 levels) in start_workers'
<internal:core> core/kernel.rb:417:in `loop'
/Users/dentarg/src/ractor-pool/lib/ractor-pool.rb:229:in `block (2 levels) in start_workers'
/Users/dentarg/.arm64_rubies/truffleruby-dev/lib/gems/gems/ractor-shim-0.1.0/lib/ractor/shim.rb:138:in `instance_exec'
/Users/dentarg/.arm64_rubies/truffleruby-dev/lib/gems/gems/ractor-shim-0.1.0/lib/ractor/shim.rb:138:in `block in initialize'
/Users/dentarg/.arm64_rubies/truffleruby-dev/lib/gems/gems/ractor-shim-0.1.0/lib/ractor/shim.rb:257:in `value': Ractor::RemoteError (Ractor::RemoteError)
  from /Users/dentarg/.arm64_rubies/truffleruby-dev/lib/gems/gems/ractor-shim-0.1.0/lib/ractor/shim.rb:248:in `join'
  from /Users/dentarg/src/ractor-pool/lib/ractor-pool.rb:162:in `shutdown'
  from ractor_pool_example.rb:21:in `<main>'
/Users/dentarg/src/ractor-pool/lib/ractor-pool.rb:202:in `block (2 levels) in start_coordinator': undefined method `shutdown' for an instance of Ractor::Port (NoMethodError)
  from <internal:core> core/kernel.rb:417:in `loop'
  from /Users/dentarg/src/ractor-pool/lib/ractor-pool.rb:179:in `block in start_coordinator'
  from /Users/dentarg/.arm64_rubies/truffleruby-dev/lib/gems/gems/ractor-shim-0.1.0/lib/ractor/shim.rb:138:in `instance_exec'
  from /Users/dentarg/.arm64_rubies/truffleruby-dev/lib/gems/gems/ractor-shim-0.1.0/lib/ractor/shim.rb:138:in `block in initialize'
```
