require "pp"
require "sinatra/base"

class UsedMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    PP.pp("Hello from #{self.class.name}")
    @app.call(env)
  end
end

class InsertedMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    PP.pp("Hello from #{self.class.name}")
    @app.call(env)
  end
end

class App < Sinatra::Base
  use UsedMiddleware

  get "/" do
    body "OK"
  end

  def self.setup_default_middleware(builder)
    super

    PP.pp(builder.instance_variable_get(:@use))
    PP.pp("---")
    builder.instance_variable_get(:@use).insert(0, proc { |app| InsertedMiddleware.new(app) })
    PP.pp(builder.instance_variable_get(:@use))
  end
end
