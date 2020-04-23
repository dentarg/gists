# frozen_string_literal: true

class FooController < BaseController
  get "/" do
    body "foo"
  end
end
