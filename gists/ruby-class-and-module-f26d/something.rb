class Something
  def FooBar(var)
    helper(var)
  end

  private

  def helper(var)
    puts "self.name: #{self.class.name}"
    puts "Something var: #{var}"
  end
end
