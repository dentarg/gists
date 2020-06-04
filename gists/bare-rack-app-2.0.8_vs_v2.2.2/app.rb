# frozen_string_literal: true

require "rack"

class App
  URL = "https://www.google.com/"

  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    response.redirect(URL)
    # Fix for rack v2.1.0+, one of
    # response.finish
    # response.to_a
    response
  end
end
