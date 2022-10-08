require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  let!(:room) { create(:room, :main) }

  describe "GET /new" do
    it "returns http success" do
      get "/rooms/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /rooms (index)" do
    it "returns http success" do
      get "/rooms"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/rooms/#{room.id}"
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
