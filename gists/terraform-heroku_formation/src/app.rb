# frozen_string_literal: true

$stdout.sync = true
$stderr.sync = true

puts "hello from app worker"

while true
  puts "."
  sleep 0.5
end
