class Klass
  def self.foo
  end
end

module ExtendSelf
  extend self

  def foo
  end
end

p RUBY_DESCRIPTION

p "Klass"
p Klass.singleton_methods      # => [:foo]
p Klass.singleton_method(:foo) # => #<Method: Klass.foo() singleton_method.rb:2>

p "ExtendSelf"
p ExtendSelf.singleton_methods      # => [:foo]
p ExtendSelf.singleton_method(:foo) # => singleton_method.rb:19:in `singleton_method': undefined singleton method `foo' for `ExtendSelf' (NameError)
