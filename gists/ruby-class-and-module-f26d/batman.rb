class Batman
  def Joker(var)
    helper(var)
  end

  private

  def helper(var)
    puts "self.name: #{self.class.name}"
    puts "Batman var: #{var}"
  end
end
