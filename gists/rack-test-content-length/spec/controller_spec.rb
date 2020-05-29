# frozen_string_literal: true

RSpec.describe Controller do
  def app
    OUTER_APP
  end

  describe "GET /" do
    before do
      header "Accept-Encoding", "gzip"

      get "/"
    end

    it do
      p last_response.headers
      expect(last_response.body).to eq("root")
    end
  end
end
