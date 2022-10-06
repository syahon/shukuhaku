require 'rails_helper'

RSpec.describe "Login", type: :system do
  let!(:user) { create(:user) }

  describe "ユーザーのログイン" do
    context "パスワードが間違っている場合" do
      it "ログインに失敗すること" do
        visit login_path

        fill_in "メールアドレス", with: user.mail
        fill_in "パスワード", with: "foo"

        find("#login").click

        expect(current_path).to_not eq root_path
        expect(page).to have_content "入力したメールアドレスまたはパスワードが間違っています"
      end
    end

    context "正しい値を入力した場合" do
      it "ログインに成功すること" do
        visit login_path

        fill_in "メールアドレス", with: user.mail
        fill_in "パスワード", with: "password"

        find("#login").click

        expect(current_path).to eq root_path
      end
    end
  end
end
