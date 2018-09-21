require "oj"

class MyParser < ::Oj::ScHandler
  def initialize(&url_handler)
    @url_handler = url_handler
  end

  def hash_start
    {}
  end

  def hash_set(h,k,v)
    h[k] = v
  end

  def array_start
    []
  end

  def array_append(a,v)
    a << v
  end

  def add_value(value)
    puts value
  end
end
