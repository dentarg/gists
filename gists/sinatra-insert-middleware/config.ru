require_relative "app"

class FirstConfigRuMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    PP.pp("Hello from #{self.class.name}")
    @app.call(env)
  end
end

class SecondConfigRuMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    PP.pp("Hello from #{self.class.name}")
    @app.call(env)
  end
end

use FirstConfigRuMiddleware
use SecondConfigRuMiddleware

run App
