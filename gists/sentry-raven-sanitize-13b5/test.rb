require "rack/test"
require "raven"
require "test/unit"

Raven.configure do |config|
  config.logger.level = "DEBUG"
end

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      use Raven::Rack

      map "/" do
        run lambda { |env|
          raise "Foo"

          [200, {'Content-Type' => 'text/plain'}, ['OK']]
        }
      end
    end
  end

  def test_ok
    get "/?foo=bar%E9"
    assert last_response.ok?
  end
end
