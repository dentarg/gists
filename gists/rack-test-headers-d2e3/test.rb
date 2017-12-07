require "test/unit"
require "rack/test"
require "sinatra/base"
require "json"

class App < Sinatra::Base
  post '/user/create' do
    api_key = headers[ 'X-Blah-Token' ]
    body    = request.body.read
    # ...
  end
end

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    App
  end

  def test_ok
    body   = { 'name' => 'joe' }.to_json
    headers = { 'X-Blah-Token' => '12345...' }
    headers = { 'HTTP_X_BLAH_TOKEN' => '12345...' }
    # header headers

    post '/user/create', body, headers # => Doh! header arrives as 'HTTP_X_Blah_Token'

    p "--- last_request.env['HTTP_X_BLAH_TOKEN']: #{last_request.env['HTTP_X_BLAH_TOKEN']}"
    p "--- last_response.headers:"
    p last_response.headers

    assert_equal last_response.headers['X-Blah-Token'], '12345...'
    assert last_response.ok?
  end
end
