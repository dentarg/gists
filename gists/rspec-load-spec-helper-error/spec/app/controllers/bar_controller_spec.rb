# frozen_string_literal: true

RSpec.describe BarController do
  def app
    OUTER_APP
  end

  describe "GET /bar" do
    before { get "/bar" }

    it do
      expect(last_response.body).to eq("bar")
    end
  end
end
