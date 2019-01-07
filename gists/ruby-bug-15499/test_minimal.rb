# frozen_string_literal: true

$stdout.sync = true
$stderr.sync = true

puts "RUBY_VERSION: #{RUBY_VERSION}"

env = {}
command = "bundle exec puma -C config/puma.rb"

puts command

pid = Process.spawn(env, command, out: STDOUT, err: STDERR)
puts "Process started with PID: #{pid}"
Process.detach(pid) # avoid zombie processes
puts "Process detached"
puts "Sleeping 3 seconds... (1)" ; sleep 3

puts "Sending TERM signal"
Process.kill(:TERM, pid)
puts "Sleeping 3 seconds... (2)" ; sleep 3
puts "Waiting..."
Process.wait(pid)
