# frozen_string_literal: true

require "sinatra/base"

class Controller < Sinatra::Base
  get "/" do
    redirect "/login"
  end

  get "/big" do
    body "foo"*10
  end
end
