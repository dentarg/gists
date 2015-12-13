require_relative "something"
require_relative "batman"

module MyModule
  module_function

  # include Batman
  # include Something

  def foo_bar
    Something.new.FooBar(:a)
  end

  def joker
    Batman.new.Joker(:b)
  end
end

# MyModule.new.foo_bar
# MyModule.new.joker

MyModule.foo_bar
MyModule.joker
