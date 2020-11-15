# ruby (+ puma) bug

Links

* From https://github.com/jruby/jruby/issues/5576
  * > rb_waitpid reimplemented on Unix-like platforms to maintain compatibility with processes created for JIT [Bug #14867](https://bugs.ruby-lang.org/issues/14867)
    * Last comment links to https://bugs.ruby-lang.org/issues/14968
* Related(?) ruby bug https://bugs.ruby-lang.org/issues/15499
  * my comments from https://bugs.ruby-lang.org/issues/15499#note-9
* Puma issues / pull requests
  * https://github.com/puma/puma/issues/1674 "Puma hangs on shutting down workers when received SIGINT"
  * https://github.com/puma/puma/issues/1703 "Travis - Ruby head/trunk test failures"
  * https://github.com/puma/puma/issues/1720 "TestIntegration#test_term_signal_exit_code_in_clustered_mode fails"
  * https://github.com/puma/puma/issues/1730 "Slow restarts"
  * https://github.com/puma/puma/pull/1738 "Use Process::WNOHANG flag when stoping child workers processes."
  * https://github.com/puma/puma/pull/1741 "cluster - worker shutdown - use WNOHANG with nil return tests" (merged)
  * https://github.com/puma/puma/issues/1755 "Hang on SIGTERM with ruby 2.6 in clustered mode"
* comments by evanphx
  * https://github.com/puma/puma/pull/1741#issuecomment-474128019
  * https://github.com/puma/puma/issues/1730#issuecomment-474678949

## ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-darwin18]

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.7.1
    bundle exec puma -C config/puma.rb
    Process started with PID: 29385
    Process detached
    Sleeping 3 seconds... (1)
    [29385] Puma starting in cluster mode...
    [29385] * Version 3.12.0 (ruby 2.7.1-p83), codename: Llamas in Pajamas
    [29385] * Min threads: 16, max threads: 16
    [29385] * Environment: development
    [29385] * Process workers: 2
    [29385] * Preloading application
    [29385] * Listening on tcp://0.0.0.0:3000
    [29385] Use Ctrl-C to stop
    [29385] - Worker 0 (pid: 29393) booted, phase: 0
    [29385] - Worker 1 (pid: 29394) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [29385] - Gracefully shutting down workers...
    Waiting...
    ^CTraceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': Interrupt

waited 1m 28s above before pressing `^C`

    $ ps aux | grep -e ruby -e puma
    dentarg          29385 100.0  0.4  4369596  30856 s001  R    11:36AM   1:50.87 puma 3.12.0 (tcp://0.0.0.0:3000) [ruby-bug-15499]
    dentarg          29393   0.0  0.0        0      0 s001  Z    11:36AM   0:00.00 (ruby)
    dentarg          38863   0.0  0.0  4299432    500 s001  R+   11:38AM   0:00.00 grep --color=auto -e ruby -e puma
    dentarg          29394   0.0  0.0        0      0 s001  Z    11:36AM   0:00.00 (ruby)

## ruby 2.6.4p104 (2019-08-28 revision 67798) [x86_64-darwin18]

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.6.4
    bundle exec puma -C config/puma.rb
    Process started with PID: 27849
    Process detached
    Sleeping 3 seconds... (1)
    [27849] Puma starting in cluster mode...
    [27849] * Version 3.12.0 (ruby 2.6.4-p104), codename: Llamas in Pajamas
    [27849] * Min threads: 16, max threads: 16
    [27849] * Environment: development
    [27849] * Process workers: 2
    [27849] * Preloading application
    [27849] * Listening on tcp://0.0.0.0:3000
    [27849] Use Ctrl-C to stop
    [27849] - Worker 0 (pid: 27850) booted, phase: 0
    [27849] - Worker 1 (pid: 27851) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [27849] - Gracefully shutting down workers...
    Waiting...
    ^CTraceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': Interrupt

waited 5m 8s above before pressing `^C`

    $ ps aux | grep -e ruby -e puma
    dentarg          27849 100.0  0.0  5008920  32656 s016  R     2:02PM   5:27.21 puma 3.12.0 (tcp://0.0.0.0:3000) [ruby-bug-15499]
    dentarg          27851   0.0  0.0        0      0 s016  Z     2:02PM   0:00.00 (ruby)
    dentarg          27850   0.0  0.0        0      0 s016  Z     2:02PM   0:00.00 (ruby)
    dentarg          28366   0.0  0.0  4408256    844 s016  S+    2:07PM   0:00.00 grep --color=auto -e ruby -e puma

    $ kill -6 27849

    $ ps aux | grep -e ruby -e puma
    dentarg          28492   0.0  0.0  4399040    820 s016  S+    2:07PM   0:00.00 grep --color=auto -e ruby -e puma

## ruby 2.7.0preview1 (2019-05-31 trunk c55db6aa271df4a689dc8eb0039c929bf6ed43ff) [x86_64-darwin18]

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.7.0
    bundle exec puma -C config/puma.rb
    Process started with PID: 22292
    Process detached
    Sleeping 3 seconds... (1)
    [22292] Puma starting in cluster mode...
    [22292] * Version 3.12.0 (ruby 2.7.0-p-1), codename: Llamas in Pajamas
    [22292] * Min threads: 16, max threads: 16
    [22292] * Environment: development
    [22292] * Process workers: 2
    [22292] * Preloading application
    [22292] * Listening on tcp://0.0.0.0:3000
    [22292] Use Ctrl-C to stop
    [22292] - Worker 0 (pid: 22293) booted, phase: 0
    [22292] - Worker 1 (pid: 22294) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [22292] - Gracefully shutting down workers...
    Waiting...
    ^CTraceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': Interrupt

waited 57s above before pressing `^C`

    $ ps aux | grep -e ruby -e puma
    dentarg          22292 100.0  0.0  5168824  31688 s002  R    12:22PM   0:59.73 puma 3.12.0 (tcp://0.0.0.0:3000) [ruby-bug-15499]
    dentarg          22294   0.0  0.0        0      0 s002  Z    12:22PM   0:00.00 (ruby)
    dentarg          22293   0.0  0.0        0      0 s002  Z    12:22PM   0:00.00 (ruby)
    dentarg          22326   0.0  0.0  4399052    836 s002  S+   12:23PM   0:00.00 grep --color=auto -e ruby -e puma

## ruby 2.7.0dev (2019-04-02 trunk 67413) [x86_64-darwin18]

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.7.0
    bundle exec puma -C config/puma.rb
    Process started with PID: 3209
    Process detached
    Sleeping 3 seconds... (1)
    [3209] Puma starting in cluster mode...
    [3209] * Version 3.12.0 (ruby 2.7.0-p-1), codename: Llamas in Pajamas
    [3209] * Min threads: 16, max threads: 16
    [3209] * Environment: development
    [3209] * Process workers: 2
    [3209] * Preloading application
    [3209] * Listening on tcp://0.0.0.0:3000
    [3209] Use Ctrl-C to stop
    [3209] - Worker 0 (pid: 3210) booted, phase: 0
    [3209] - Worker 1 (pid: 3211) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [3209] - Gracefully shutting down workers...
    Waiting...
    ^CTraceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': Interrupt

waited 1m 14s above before pressing `^C`

    $ ps aux | grep -e ruby -e puma
    dentarg           3209  95.6  0.1  4347968  29176 s009  R     5:09PM   1:15.62 puma 3.12.0 (tcp://0.0.0.0:3000) [ruby-bug-15499]
    dentarg           3210   0.0  0.0        0      0 s009  Z     5:09PM   0:00.00 (ruby)
    dentarg           3487   0.0  0.0  4258648    208 s009  R+    5:10PM   0:00.00 grep --color=auto -e ruby -e puma
    dentarg           3211   0.0  0.0        0      0 s009  Z     5:09PM   0:00.00 (ruby)

## 2.6.2

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.6.2
    bundle exec puma -C config/puma.rb
    Process started with PID: 65977
    Process detached
    Sleeping 3 seconds... (1)
    [65977] Puma starting in cluster mode...
    [65977] * Version 3.12.0 (ruby 2.6.2-p47), codename: Llamas in Pajamas
    [65977] * Min threads: 16, max threads: 16
    [65977] * Environment: development
    [65977] * Process workers: 2
    [65977] * Preloading application
    [65977] * Listening on tcp://0.0.0.0:3000
    [65977] Use Ctrl-C to stop
    [65977] - Worker 0 (pid: 65978) booted, phase: 0
    [65977] - Worker 1 (pid: 65979) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [65977] - Gracefully shutting down workers...
    Waiting...
    ^CTraceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': Interrupt

waited 1m 9s above before pressing ^C

    $ ps aux | grep -e ruby -e puma
    dentarg          65977 100.0  0.1  4376312  29768 s011  R     9:20AM   1:09.02 puma 3.12.0 (tcp://0.0.0.0:3000) [ruby-bug-15499]
    dentarg          65979   0.0  0.0        0      0 s011  Z     9:20AM   0:00.00 (ruby)
    dentarg          65978   0.0  0.0        0      0 s011  Z     9:20AM   0:00.00 (ruby)
    dentarg          66014   0.0  0.0  4287492    852 s011  S+    9:21AM   0:00.00 grep --color=auto -e ruby -e puma

## 2.6.1 + https://github.com/puma/puma/pull/1741

    $ bundle exec --gemfile=Gemfile_1741 ruby test_minimal.rb
    RUBY_VERSION: 2.6.1
    bundle exec puma -C config/puma.rb
    Process started with PID: 88315
    Process detached
    Sleeping 3 seconds... (1)
    [88315] Puma starting in cluster mode...
    [88315] * Version 3.12.0 (ruby 2.6.1-p33), codename: Llamas in Pajamas
    [88315] * Min threads: 16, max threads: 16
    [88315] * Environment: development
    [88315] * Process workers: 2
    [88315] * Preloading application
    [88315] * Listening on tcp://0.0.0.0:3000
    [88315] Use Ctrl-C to stop
    [88315] - Worker 0 (pid: 88316) booted, phase: 0
    [88315] - Worker 1 (pid: 88317) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [88315] - Gracefully shutting down workers...
    [88315]     worker status: pid 88316 exit 0
    [88315]     worker status: pid 88317 exit 0
    [88315]     worker shutdown time:   0.50
    Waiting...
    Traceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': No child processes (Errno::ECHILD)

<!-- -->

    $ ps aux | grep -e ruby -e puma
    dentarg          88417   0.0  0.0  4278260    824 s022  S+    1:36PM   0:00.01 grep --color=auto -e ruby -e puma


## 2.6.1

    $ ruby -v
    ruby 2.6.1p33 (2019-01-30 revision 66950) [x86_64-darwin18]

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.6.1
    bundle exec puma -C config/puma.rb
    Process started with PID: 28284
    Process detached
    Sleeping 3 seconds... (1)
    [28284] Puma starting in cluster mode...
    [28284] * Version 3.12.0 (ruby 2.6.1-p33), codename: Llamas in Pajamas
    [28284] * Min threads: 16, max threads: 16
    [28284] * Environment: development
    [28284] * Process workers: 2
    [28284] * Preloading application
    [28284] * Listening on tcp://0.0.0.0:3000
    [28284] Use Ctrl-C to stop
    [28284] - Worker 0 (pid: 28291) booted, phase: 0
    [28284] - Worker 1 (pid: 28292) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [28284] - Gracefully shutting down workers...
    Waiting...
    ^CTraceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': Interrupt

    # waited 2m 28s above

    $ ps aux | grep -e ruby -e puma
    dentarg          28284  99.9  0.1  4348640  29316 s027  R     4:49PM   2:26.08 puma 3.12.0 (tcp://0.0.0.0:3000) [ruby-bug-15499]
    dentarg          28291   0.0  0.0        0      0 s027  Z     4:49PM   0:00.00 (ruby)
    dentarg          28810   0.0  0.0  4279284    800 s027  R+    4:51PM   0:00.00 grep --color=auto -e ruby -e puma
    dentarg          28292   0.0  0.0        0      0 s027  Z     4:49PM   0:00.00 (ruby)

    $ kill -6 28284

    $ ps aux | grep -e ruby -e puma
    dentarg          28920   0.0  0.0  4268020    772 s027  S+    4:52PM   0:00.00 grep --color=auto -e ruby -e puma

## 2.7.0dev (2019-01-05 trunk 66716)

    $ ruby -v
    ruby 2.7.0dev (2019-01-05 trunk 66716) [x86_64-darwin18]

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.7.0
    bundle exec puma -C config/puma.rb
    Process started with PID: 21725
    Process detached
    Sleeping 3 seconds... (1)
    [21725] Puma starting in cluster mode...
    [21725] * Version 3.12.0 (ruby 2.7.0-p-1), codename: Llamas in Pajamas
    [21725] * Min threads: 16, max threads: 16
    [21725] * Environment: development
    [21725] * Process workers: 2
    [21725] * Preloading application
    [21725] * Listening on tcp://0.0.0.0:3000
    [21725] Use Ctrl-C to stop
    [21725] - Worker 0 (pid: 21726) booted, phase: 0
    [21725] - Worker 1 (pid: 21727) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [21725] - Gracefully shutting down workers...
    Waiting...
    ^CTraceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': Interrupt


    $ ps aux | grep -e ruby -e puma
    dentarg          21725 100.0  0.1  4347228  29752 s025  R     6:36PM   0:29.02 puma 3.12.0 (tcp://0.0.0.0:3000) [ruby-bug-15499]
    dentarg          21726   0.0  0.0        0      0 s025  Z     6:36PM   0:00.00 (ruby)
    dentarg          21727   0.0  0.0        0      0 s025  Z     6:36PM   0:00.00 (ruby)
    dentarg          21824   0.0  0.0  4270068    500 s025  R+    6:37PM   0:00.00 grep --color=auto -e ruby -e puma

    $ kill -3 21725

    $ ps aux | grep -e ruby -e puma
    dentarg          21725  98.8  0.1  4347228  29752 s025  R     6:36PM   0:43.74 puma 3.12.0 (tcp://0.0.0.0:3000) [ruby-bug-15499]
    dentarg          21726   0.0  0.0        0      0 s025  Z     6:36PM   0:00.00 (ruby)
    dentarg          21727   0.0  0.0        0      0 s025  Z     6:36PM   0:00.00 (ruby)
    dentarg          21874   0.0  0.0  4295668    828 s025  S+    6:37PM   0:00.00 grep --color=auto -e ruby -e puma

    $ kill -6 21725

    $ ps aux | grep -e ruby -e puma
    dentarg          21897   0.0  0.0  4268020    780 s025  S+    6:37PM   0:00.00 grep --color=auto -e ruby -e puma

## 2.6.0

    $ ruby -v
    ruby 2.6.0p0 (2018-12-25 revision 66547) [x86_64-darwin18]

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.6.0
    bundle exec puma -C config/puma.rb
    Process started with PID: 14660
    Process detached
    Sleeping 3 seconds... (1)
    [14660] Puma starting in cluster mode...
    [14660] * Version 3.12.0 (ruby 2.6.0-p0), codename: Llamas in Pajamas
    [14660] * Min threads: 16, max threads: 16
    [14660] * Environment: development
    [14660] * Process workers: 2
    [14660] * Preloading application
    [14660] * Listening on tcp://0.0.0.0:3000
    [14660] Use Ctrl-C to stop
    [14660] - Worker 0 (pid: 14662) booted, phase: 0
    [14660] - Worker 1 (pid: 14663) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [14660] - Gracefully shutting down workers...
    Waiting...
    ^CTraceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': Interrupt

    $ ps aux | grep -e ruby -e puma
    dentarg          14660  98.9  0.1  4348244  30088 s025  R     6:09PM   0:21.07 puma 3.12.0 (tcp://0.0.0.0:3000) [ruby-bug-15499]
    dentarg          14662   0.0  0.0        0      0 s025  Z     6:09PM   0:00.00 (ruby)
    dentarg          14663   0.0  0.0        0      0 s025  Z     6:09PM   0:00.00 (ruby)
    dentarg          14742   0.0  0.0  4258736    196 s025  R+    6:09PM   0:00.00 grep --color=auto -e ruby -e puma

    $ kill -6 14660

    $ ps aux | grep -e ruby -e puma
    dentarg          14766   0.0  0.0  4277236    804 s025  S+    6:09PM   0:00.00 grep --color=auto -e ruby -e puma

<!-- -->

# Works

## 2.5.6

Still good

    $ ps aux | grep -e ruby -e puma
    dentarg          29514   0.0  0.0  4408256    852 s016  S+    2:10PM   0:00.00 grep --color=auto -e ruby -e puma

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.5.6
    bundle exec puma -C config/puma.rb
    Process started with PID: 29553
    Process detached
    Sleeping 3 seconds... (1)
    [29553] Puma starting in cluster mode...
    [29553] * Version 3.12.0 (ruby 2.5.6-p201), codename: Llamas in Pajamas
    [29553] * Min threads: 16, max threads: 16
    [29553] * Environment: development
    [29553] * Process workers: 2
    [29553] * Preloading application
    [29553] * Listening on tcp://0.0.0.0:3000
    [29553] Use Ctrl-C to stop
    [29553] - Worker 0 (pid: 29554) booted, phase: 0
    [29553] - Worker 1 (pid: 29555) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [29553] - Gracefully shutting down workers...
    Waiting...
    Traceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': No child processes (Errno::ECHILD)

    $ ps aux | grep -e ruby -e puma
    dentarg          29596   0.0  0.0  4399040    820 s016  S+    2:11PM   0:00.00 grep --color=auto -e ruby -e puma

## 2.5.5

Still good

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.5.5
    bundle exec puma -C config/puma.rb
    Process started with PID: 71261
    Process detached
    Sleeping 3 seconds... (1)
    [71261] Puma starting in cluster mode...
    [71261] * Version 3.12.0 (ruby 2.5.5-p157), codename: Llamas in Pajamas
    [71261] * Min threads: 16, max threads: 16
    [71261] * Environment: development
    [71261] * Process workers: 2
    [71261] * Preloading application
    [71261] * Listening on tcp://0.0.0.0:3000
    [71261] Use Ctrl-C to stop
    [71261] - Worker 0 (pid: 71262) booted, phase: 0
    [71261] - Worker 1 (pid: 71263) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [71261] - Gracefully shutting down workers...
    Waiting...
    Traceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': No child processes (Errno::ECHILD)

<!-- -->

    $ ps aux | grep -e ruby -e puma
    dentarg          71502   0.0  0.0  4278280    816 s003  S+   10:46AM   0:00.00 grep --color=auto -e ruby -e puma

## 2.5.3

How it should work?

    $ ruby -v
    ruby 2.5.3p105 (2018-10-18 revision 65156) [x86_64-darwin17]

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.5.3
    bundle exec puma -C config/puma.rb
    Process started with PID: 15364
    Process detached
    Sleeping 3 seconds... (1)
    [15364] Puma starting in cluster mode...
    [15364] * Version 3.12.0 (ruby 2.5.3-p105), codename: Llamas in Pajamas
    [15364] * Min threads: 16, max threads: 16
    [15364] * Environment: development
    [15364] * Process workers: 2
    [15364] * Preloading application
    [15364] * Listening on tcp://0.0.0.0:3000
    [15364] Use Ctrl-C to stop
    [15364] - Worker 0 (pid: 15365) booted, phase: 0
    [15364] - Worker 1 (pid: 15366) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [15364] - Gracefully shutting down workers...
    Waiting...
    Traceback (most recent call last):
        1: from test_minimal.rb:23:in `<main>'
    test_minimal.rb:23:in `wait': No child processes (Errno::ECHILD)

    $ ps aux | grep -e ruby -e puma
    dentarg          15406   0.0  0.0  4268020    432 s025  R+    6:11PM   0:00.00 grep --color=auto -e ruby -e puma

<!-- -->

    $ uname -a
    Darwin pimac 18.2.0 Darwin Kernel Version 18.2.0: Mon Nov 12 20:24:46 PST 2018; root:xnu-4903.231.4~2/RELEASE_X86_64 x86_64

## 2.4.6

Also good

    $ ruby test_minimal.rb
    RUBY_VERSION: 2.4.6
    bundle exec puma -C config/puma.rb
    Process started with PID: 71975
    Process detached
    Sleeping 3 seconds... (1)
    [71975] Puma starting in cluster mode...
    [71975] * Version 3.12.0 (ruby 2.4.6-p354), codename: Llamas in Pajamas
    [71975] * Min threads: 16, max threads: 16
    [71975] * Environment: development
    [71975] * Process workers: 2
    [71975] * Preloading application
    [71975] * Listening on tcp://0.0.0.0:3000
    [71975] Use Ctrl-C to stop
    [71975] - Worker 0 (pid: 71978) booted, phase: 0
    [71975] - Worker 1 (pid: 71979) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [71975] - Gracefully shutting down workers...
    Waiting...
    test_minimal.rb:23:in `wait': No child processes (Errno::ECHILD)
        from test_minimal.rb:23:in `<main>'

<!-- -->

    $ ps aux | grep -e ruby -e puma
    dentarg          72038   0.0  0.0  4279196    644 s003  R+   10:47AM   0:00.00 grep --color=auto -e ruby -e puma

---

# workaround

## 2.7.0dev (same as above) `Thread.new { sleep }` workaround

    $ ruby test_minimal_w_workaround.rb
    RUBY_VERSION: 2.7.0
    bundle exec puma -C config/puma.rb
    Process started with PID: 24844
    Process detached
    Sleeping 3 seconds... (1)
    [24844] Puma starting in cluster mode...
    [24844] * Version 3.12.0 (ruby 2.7.0-p-1), codename: Llamas in Pajamas
    [24844] * Min threads: 16, max threads: 16
    [24844] * Environment: development
    [24844] * Process workers: 2
    [24844] * Preloading application
    [24844] * Listening on tcp://0.0.0.0:3000
    [24844] Use Ctrl-C to stop
    [24844] - Worker 0 (pid: 24845) booted, phase: 0
    [24844] - Worker 1 (pid: 24846) booted, phase: 0
    Sending TERM signal
    Sleeping 3 seconds... (2)
    [24844] - Gracefully shutting down workers...
    Waiting...
    ^CTraceback (most recent call last):
        1: from test_minimal_w_workaround.rb:25:in `<main>'
    test_minimal_w_workaround.rb:25:in `wait': Interrupt


    $ ps aux | grep -e ruby -e puma
    dentarg          24844  99.5  0.1  4347228  29616 s025  R     6:50PM   0:16.11 puma 3.12.0 (tcp://0.0.0.0:3000) [ruby-bug-15499]
    dentarg          24845   0.0  0.0        0      0 s025  Z     6:50PM   0:00.00 (ruby)
    dentarg          24846   0.0  0.0        0      0 s025  Z     6:50PM   0:00.00 (ruby)
    dentarg          24908   0.0  0.0  4258736    196 s025  U+    6:50PM   0:00.00 grep --color=auto -e ruby -e puma

    $ kill -6 24844

    $ ps aux | grep -e ruby -e puma
    dentarg          24934   0.0  0.0  4277236    792 s025  S+    6:51PM   0:00.00 grep --color=auto -e ruby -e puma
