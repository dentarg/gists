for https://github.com/ohler55/oj/issues/503

```
$ ruby -r oj -r ./handler -e 'File.open("working.json", "r") { |f| Oj.sc_parse(MyParser.new, f) }'
{"test"=>[]}
```

```
$ ruby -r oj -r ./handler -e 'File.open("error.json", "r") { |f| Oj.sc_parse(MyParser.new, f) }'
-e:1:in `BigDecimal': invalid value for BigDecimal(): "-e1535637460290" (ArgumentError)
    from -e:1:in `sc_parse'
    from -e:1:in `block in <main>'
    from -e:1:in `open'
    from -e:1:in `<main>'
```
