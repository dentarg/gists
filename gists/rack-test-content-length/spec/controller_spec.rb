# frozen_string_literal: true

RSpec.describe Controller do
  def app
    OUTER_APP
  end

  describe "GET / (deflate)" do
    before do
      header "Accept-Encoding", "deflate"

      get "/"
    end

    it do
      aggregate_failures do
        expect(last_response.headers).to eq({})
        expect(last_response.body).to eq("root")
      end
    end
  end

  describe "GET / (gzip)" do
    before do
      header "Accept-Encoding", "gzip"

      get "/"
    end

    it do
      aggregate_failures do
        expect(last_response.headers).to eq({})
        expect(last_response.body).to eq("root")
      end
    end
  end
end
