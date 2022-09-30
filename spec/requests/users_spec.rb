require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
  describe "GET /sign_up (new)" do
    it "returns http success" do
      get "/sign_up"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/users/#{user.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
