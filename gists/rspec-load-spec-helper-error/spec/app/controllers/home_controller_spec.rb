# frozen_string_literal: true

RSpec.describe HomeController do
  def app
    OUTER_APP
  end

  describe "GET /" do
    before { get "/" }

    it do
      expect(last_response.body).to eq("home")
    end
  end
end
