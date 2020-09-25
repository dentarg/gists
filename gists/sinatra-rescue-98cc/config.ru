require 'sinatra/base'

class App < Sinatra::Base
  get '/' do
    raise "Boom!"
  rescue
    body "This is the rescue"
  end
end

run App
