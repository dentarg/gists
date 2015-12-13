module Foo
  module_function

  def bar
    puts :bar
  end
end

class Bar
  include Foo
end

class MyAppModel
   class << self
     # ensure that your constructor can't be called from the outside
     protected :new

    def construct_from_some_other_object other_object
      new(other_object.foo)
    end

    def helper
      new(get_it_from_file(file))
    end
   end

  def initialize(my_var)
    @my_var = my_var
  end
end
