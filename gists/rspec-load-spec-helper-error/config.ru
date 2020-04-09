# frozen_string_literal: true

require_relative "lib/app"
require_relative "lib/foo"

run lambda { |env| [200, {"Content-Type" => "text/plain"}, [App.new.hello]] }
