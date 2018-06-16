# rubyXL issue repro

Using `rubyXL-3.3.29` and `ruby 2.4.2p198`.

    bundle
    bundle exec ruby repro.rb

or

    gem install rubyXL
    ruby -rrubyXL -e'RubyXL::Parser.parse("./TestCloneSheetWithCustomProperty.xlsm")'

the warning:

```
*** WARNING: storage class not found for ../customProperty1.bin (http://schemas.openxmlformats.org/officeDocument/2006/relationships/customProperty)
WARNING: RubyXL::Worksheet is not aware what to do with RubyXL::GenericStorageObject
```

(xlsm file found at https://bz.apache.org/bugzilla/show_bug.cgi?id=60512)
