for https://github.com/ohler55/oj/issues/503

oj-3.6.10:

```
$ BUNDLE_GEMFILE=stable.Gemfile bundle exec ruby -r bundler/setup -r oj -r ./handler -e 'File.open("working.json", "r") { |f| Oj.sc_parse(MyParser.new, f) }'
{"test"=>[]}
```

```
$ BUNDLE_GEMFILE=stable.Gemfile bundle exec ruby -r bundler/setup -r oj -r ./handler -e 'File.open("error.json", "r") { |f| Oj.sc_parse(MyParser.new, f) }'
-e:1:in `BigDecimal': invalid value for BigDecimal(): "-e1535637460290" (ArgumentError)
    from -e:1:in `sc_parse'
    from -e:1:in `block in <main>'
    from -e:1:in `open'
    from -e:1:in `<main>'

$ BUNDLE_GEMFILE=stable.Gemfile bundle exec ruby -r bundler/setup -r oj -e 'Oj.mimic_JSON.parse("{\"number\":-e1535637460290}")'
-e:1:in `BigDecimal': invalid value for BigDecimal(): "-e1535637460290" (ArgumentError)
    from -e:1:in `parse'
    from -e:1:in `<main>'

$ BUNDLE_GEMFILE=stable.Gemfile bundle exec ruby -r bundler/setup -r oj -e 'Oj.mimic_JSON.load("{\"number\":-e1535637460290}")'
-e:1:in `BigDecimal': invalid value for BigDecimal(): "-e1535637460290" (ArgumentError)
    from -e:1:in `load'
    from -e:1:in `<main>'
```

with https://github.com/ohler55/oj/commit/acca4831ff2bbaad5d5dae34f387864f30c05d71

```
$ BUNDLE_GEMFILE=acca483.Gemfile bundle exec ruby -r bundler/setup -r oj -r ./handler -e 'File.open("error.json", "r") { |f| Oj.sc_parse(MyParser.new, f) }'
-e:1:in `BigDecimal': invalid value for BigDecimal(): "-e1535637460290" (ArgumentError)
    from -e:1:in `sc_parse'
    from -e:1:in `block in <main>'
    from -e:1:in `open'
    from -e:1:in `<main>'

$ BUNDLE_GEMFILE=acca483.Gemfile bundle exec ruby -r bundler/setup -r oj -e 'Oj.load("{\"number\":-e1535637460290}")'
-e:1:in `load': Hash/Object not terminated (number) at line 1, column 25 [parse.c:983] (Oj::ParseError)
    from -e:1:in `<main>'

$ BUNDLE_GEMFILE=acca483.Gemfile bundle exec ruby -r bundler/setup -r oj -e 'Oj.mimic_JSON.load("{\"number\":-e1535637460290}")'
-e:1:in `load': Hash/Object not terminated (number) at line 1, column 25 [parse.c:983] in '{"number":-e1535637460290} (Oj::ParseError)
    from -e:1:in `<main>'

$ BUNDLE_GEMFILE=acca483.Gemfile bundle exec ruby -r bundler/setup -r oj -e 'Oj.mimic_JSON.parse("{\"number\":-e1535637460290}")'
-e:1:in `parse': Hash/Object not terminated (number) at line 1, column 25 [parse.c:983] in '{"number":-e1535637460290} (JSON::ParserError)
    from -e:1:in `<main>'
```

with also https://github.com/ohler55/oj/commit/5bce71426b73e4cdd87f36a1bb5b082722fd1a44

```
$ bundle exec ruby -r bundler/setup -r oj -r ./handler -e 'File.open("error.json", "r") { |f| Oj.sc_parse(MyParser.new, f) }'
-e:1:in `sc_parse': Hash/Object not terminated (number) at line 1, column 25 [sparse.c:863] (Oj::ParseError)
    from -e:1:in `block in <main>'
    from -e:1:in `open'
    from -e:1:in `<main>'

$ bundle exec ruby -r bundler/setup -r oj -e 'Oj.load("{\"number\":-e1535637460290}")'
-e:1:in `load': Hash/Object not terminated (number) at line 1, column 25 [parse.c:990] (Oj::ParseError)
    from -e:1:in `<main>'

$ bundle exec ruby -r bundler/setup -r oj -e 'Oj.mimic_JSON.load("{\"number\":-e1535637460290}")'
-e:1:in `load': Hash/Object not terminated (number) at line 1, column 25 [parse.c:990] in '{"number":-e1535637460290} (Oj::ParseError)
    from -e:1:in `<main>'

$ bundle exec ruby -r bundler/setup -r oj -e 'Oj.mimic_JSON.parse("{\"number\":-e1535637460290}")'
-e:1:in `parse': Hash/Object not terminated (number) at line 1, column 25 [parse.c:990] in '{"number":-e1535637460290} (JSON::ParserError)
    from -e:1:in `<main>'
```
