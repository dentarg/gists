puts 'RUBY_VERSION:'
puts RUBY_VERSION

puts '__FILE__:'
puts __FILE__

puts 'File.basename(__FILE__):'
puts File.basename(__FILE__)

puts '__dir__:'
puts __dir__

puts 'File.expand_path("..", __dir__):'
puts File.expand_path("..", __dir__)

puts "__dir__"
puts __dir__

puts 'File.join(__dir__, "lib"):'
puts File.join(__dir__, "lib")

puts 'File.join(__FILE__, "lib"):'
puts File.join(__FILE__, "lib")

puts 'File.join("..", __FILE__):'
puts File.join("..", __FILE__)

puts 'File.expand_path("..", __FILE__):'
puts File.expand_path("..", __FILE__)

puts

puts 'File.join("..", "..", __FILE__):'
puts File.join("..", "..", __FILE__)

puts

puts 'File.expand_path("..", File.join("..", __FILE__)):'
puts File.expand_path("..", File.join("..", __FILE__))
puts
puts 'File.expand_path("..", File.join("..", "..", __FILE__)):'
puts File.expand_path("..", File.join("..", "..", __FILE__))
puts
puts 'File.expand_path("..", File.join("..", "..", __FILE__)):'
puts File.expand_path("..", File.join("..", "..", __FILE__))
