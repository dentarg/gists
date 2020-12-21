require 'sinatra/base'

class App < Sinatra::Base
  get '/' do
    raise "Boom!"
  rescue
    body "This is the rescue"
  end

  get '/test' do
    if true
      halt 200, "HELLO"
    end

    body "tut"
  end
end

run App
