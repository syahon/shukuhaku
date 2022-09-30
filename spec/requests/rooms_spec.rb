require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/rooms/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/rooms/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /search" do
    it "returns http success" do
      get "/rooms/search"
      expect(response).to have_http_status(:success)
    end
  end

end
