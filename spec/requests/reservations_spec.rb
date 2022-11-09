require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  describe "GET /reservations (index)" do
    it "returns http success" do
      get "/reservations"
      expect(response).to have_http_status(:success)
    end
  end

  describe "rooms_controllerのbefore_action" do
    context "ログインせずに予約確認画面にアクセスしようとした場合" do
      it "ログインページにリダイレクトされること" do
        get new_reservation_path
        expect(response).to redirect_to login_url
        expect(flash[:danger]).to be_truthy
      end
    end
  end

end
