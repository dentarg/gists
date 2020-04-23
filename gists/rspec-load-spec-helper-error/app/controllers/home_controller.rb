# frozen_string_literal: true

class HomeController < BaseController
  get "/" do
    body "home"
  end
end
