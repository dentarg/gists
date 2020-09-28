require "sinatra/base"

class App < Sinatra::Base
  get "/" do
    body "Hello"
  end
end

run App
