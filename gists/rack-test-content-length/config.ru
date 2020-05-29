# frozen_string_literal: true

$stdout.sync = true
$stderr.sync = true

use Rack::Deflater

require_relative "controller"

map "/" do
  run Controller
end
