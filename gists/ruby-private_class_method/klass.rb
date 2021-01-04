class Klass
  # nope
  private_class_method
  def self.foo
    "self.foo"
  end

  # yes
  private_class_method \
  def self.bar
    "self.bar"
  end

  # yes
  def self.baz
    "self.baz"
  end

  private_class_method :baz, :foo
  # works too
  # private_class_method :baz, :foo
end

puts Klass.foo
# puts Klass.bar
puts Klass.baz
