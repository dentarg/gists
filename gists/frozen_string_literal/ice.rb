FROZEN = "foo".freeze
NOT_FROZEN = "foo"

frozen = "foo".freeze
not_f = "foo"

puts "RUBY_VERSION: " + RUBY_VERSION
puts
puts "FROZEN.frozen? #{FROZEN.frozen?}"
puts "NOT_FROZEN.frozen? #{NOT_FROZEN.frozen?}"
puts
puts "frozen.frozen? #{frozen.frozen?}"
puts "not_f.frozen? #{not_f.frozen?}"

# frozen_string_literal: true
