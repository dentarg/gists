# frozen_string_literal: true

require "sinatra/base"

class Controller < Sinatra::Base
  get "/" do
    redirect "/login"
  end
end
