# frozen_string_literal: true

class BarController < BaseController
  get "/" do
    body "bar"
  end
end
