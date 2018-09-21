# frozen_string_literal: true

require 'sinatra/base'

class MyMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    req.update_param('foo', 'bar')
    status, headers, response = @app.call(env)
    [status, headers, response]
  end
end

class MyApp < Sinatra::Base
  set :server, 'thin'

  use MyMiddleware

  get '/' do
    "hello"
  end
end

MyApp.run!
