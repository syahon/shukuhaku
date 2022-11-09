require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  let!(:user) { create(:user, :main) }
  let!(:room) { create(:room, :main) }
  before do
    post_login
  end

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
      get "/rooms/search?area="
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      get "/rooms/search?word="
      expect(response).to have_http_status(:success)
    end
  end

  describe "rooms_controllerのbefore_action" do
    context "ログインせずにルーム作成ページにアクセスしようとした場合" do
      it "ログインページにリダイレクトされること" do
        delete logout_path
        get new_room_path
        expect(response).to redirect_to login_url
        expect(flash[:danger]).to be_truthy
      end
    end
  end
end
