# frozen_string_literal: true

RSpec.describe "App" do
  def app
    OUTER_APP
  end

  describe "GET /" do
    before { get "/" }

    it { expect(last_response.status).to eq(200) }
    it { expect(last_response.body).to eq("Hello World") }
  end
end
