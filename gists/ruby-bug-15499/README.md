# ruby bug 15499

https://bugs.ruby-lang.org/issues/15499

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

<!-- -->

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