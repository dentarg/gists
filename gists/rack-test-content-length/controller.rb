# frozen_string_literal: true

require "sinatra/base"

class Controller < Sinatra::Base
  get "/" do
    body ""
  end
end
