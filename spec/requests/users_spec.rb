require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user, :main) }
  let!(:other_user) { create(:user, :other) }
  before do
    post login_path, params: { session: { mail: user.mail,
                                          password: "password"}}
  end

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

  describe "users_controllerのbefore_action" do
    context "自分以外のユーザーの編集ページにアクセスしようとした場合" do
      it "root_urlにリダイレクトされること" do
        get user_path(other_user)
        expect(response).to redirect_to root_url
      end
    end

    context "自分以外のユーザーの登録内容を更新しようとした場合" do
      it "更新されずroot_urlにリダイレクトされること" do
        patch user_path(other_user), params: { user: { user_name: "hoge" } }
        expect(response).to redirect_to root_url
        expect(other_user.reload.user_name).to_not eq "hoge"
      end
    end

    context "自分以外のユーザーのアカウントを削除しようとした場合" do
      it "削除されずroot_urlにリダイレクトされること" do
        users = User.all
        expect(users.count).to eq 2
        delete user_path(other_user)
        expect(response).to redirect_to root_url
        expect(users.count).to_not eq 1
      end
    end

    context "ログインせずに編集ページにアクセスしようとした場合" do
      it "ログインページにリダイレクトされること" do
        delete logout_path
        get user_path(user)
        expect(response).to redirect_to login_url
        expect(flash[:danger]).to be_truthy
      end
    end
  end

end
