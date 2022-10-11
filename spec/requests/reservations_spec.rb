require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  describe "GET /reservations (index)" do
    it "returns http success" do
      get "/reservations"
      expect(response).to have_http_status(:success)
    end
  end

end
