# frozen_string_literal: true

$stdout.sync = true
$stderr.sync = true

require_relative "config/environment"

map "/" do
  run HomeController
end

map "/bar" do
  run BarController
end

map "/foo" do
  run FooController
end
