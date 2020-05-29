# frozen_string_literal: true

require "rack/test"

OUTER_APP = Rack::Builder.parse_file("config.ru").first

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.warnings = true
end
