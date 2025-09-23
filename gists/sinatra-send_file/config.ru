# frozen_string_literal: true

require "sinatra/base"

class App < Sinatra::Base
  get "/" do
    send_file "/tmp/foo", type: "text/plain"
  end
end

run App
