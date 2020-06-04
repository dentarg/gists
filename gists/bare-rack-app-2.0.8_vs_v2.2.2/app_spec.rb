# frozen_string_literal: true

require 'rspec'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

ENV['RACK_ENV'] = 'test'

require_relative 'app'

describe App do
  def app
    App.new
  end

  context 'GET /' do
    it 'should give a redirect response' do
      get '/'

      expect(last_response.status).to eq(302)
    end
  end
end
