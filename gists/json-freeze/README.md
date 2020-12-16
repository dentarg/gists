# `JSON.parse("...", freeze: true)`

Test of https://github.com/flori/json/pull/447, parsing https://api.github.com/meta 1000 times.

    ./run_benchmark

```
+ BUNDLE_GEMFILE=json-2.3.1.Gemfile
+ bundle
Using memory_profiler 0.9.14
Using benchmark-memory 0.1.2
Using bundler 2.1.4
Using json 2.3.1
Bundle complete! 2 Gemfile dependencies, 4 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
+ BUNDLE_GEMFILE=json-2.3.1.Gemfile
+ bundle exec ruby benchmark.rb
Calculating -------------------------------------
        normal parse    88.352M memsize (     0.000  retained)
                         1.714M objects (     0.000  retained)
                        50.000  strings (     0.000  retained)
        freeze parse    88.736M memsize (     0.000  retained)
                         1.714M objects (     0.000  retained)
                        50.000  strings (     0.000  retained)

Comparison:
        normal parse:   88352000 allocated
        freeze parse:   88736000 allocated - 1.00x more
+ BUNDLE_GEMFILE=json-2.4.0.Gemfile
+ bundle
Using memory_profiler 0.9.14
Using benchmark-memory 0.1.2
Using bundler 2.1.4
Using json 2.4.0
Bundle complete! 2 Gemfile dependencies, 4 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
+ BUNDLE_GEMFILE=json-2.4.0.Gemfile
+ bundle exec ruby benchmark.rb
Calculating -------------------------------------
        normal parse   197.032M memsize (     0.000  retained)
                         1.714M objects (     0.000  retained)
                        50.000  strings (     0.000  retained)
        freeze parse    88.811M memsize (     0.000  retained)
                         1.716M objects (     0.000  retained)
                        50.000  strings (     0.000  retained)

Comparison:
        freeze parse:   88810880 allocated
        normal parse:  197032000 allocated - 2.22x more
```
