# frozen_string_literal: true

require "rack/test"

OUTER_APP = Rack::Builder.parse_file("hello.ru").first

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.expect_with(:rspec) do |expectations|
    expectations.max_formatted_output_length = nil
  end

  conf.mock_with(:rspec) do |mocks|
    mocks.verify_doubled_constant_names = true
  end

  conf.disable_monkey_patching!

  conf.filter_run_when_matching :focus

  conf.warnings = true
  conf.order = :random
end
