# frozen_string_literal: true

RSpec.describe FooController do
  def app
    OUTER_APP
  end

  describe "GET /foo" do
    before { get "/foo" }

    it do
      expect(last_response.body).to eq("foo")
    end
  end
end
