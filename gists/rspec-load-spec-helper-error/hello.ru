# frozen_string_literal: true

require_relative "app"

run lambda { |env| [200, {"Content-Type" => "text/plain"}, [App.new.hello]] }
