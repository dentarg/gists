require "test/unit"
require "rack/test"

class App1 < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      map "/foo/bar/" do
        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['foobar']] }
      end

      map "/foo/bar/baz/" do
        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['baz']] }
      end

      # map "/foo/bar/" do
      #   run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['foobar']] }
      # end
    end
  end

  def test_foo_bar
    get "/foo/bar/abc?foo=bar"

    assert last_response.ok?
    assert_equal 'foobar', last_response.body
  end

  def test_baz
    get "/foo/bar/baz/abc?foo=bar"

    assert last_response.ok?
    assert_equal 'baz', last_response.body
  end
end
