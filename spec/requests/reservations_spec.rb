require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/reservations/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /reservations (index)" do
    it "returns http success" do
      get "/reservations"
      expect(response).to have_http_status(:success)
    end
  end

end
