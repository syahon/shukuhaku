require 'rails_helper'

RSpec.describe "Login", type: :system do
  let!(:user) { create(:user, :main) }

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
        expect(user.remember_digest).to eq nil
        visit login_path

        fill_in "メールアドレス", with: user.mail
        fill_in "パスワード", with: "password"
        check "次回から自動でログインする"

        find("#login").click

        expect(user.reload.remember_digest).to_not eq nil
        expect(current_path).to eq root_path
        expect(page).to have_content "ようこそ #{user.user_name} 様"
        expect(page).to have_selector ".dropdown", text: user.user_name
      end
    end

    context "remember_meのチェックボックスのチェックを外してログインした場合" do
      it "remember_digestがnilであること" do
        expect(user.remember_digest).to eq nil
        visit login_path

        fill_in "メールアドレス", with: user.mail
        fill_in "パスワード", with: "password"
        uncheck "次回から自動でログインする"

        find("#login").click

        expect(user.reload.remember_digest).to eq nil
      end
    end
  end

  describe "ユーザーのログアウト" do
    it "ヘッダーのログアウトをクリックすることでログアウトできること" do
      user_login
      expect(user.remember_digest).to_not eq nil
      expect(page).to_not have_content "ログイン"

      find(".dropdown").click
      click_link "ログアウト"

      expect(user.reload.remember_digest).to eq nil
      expect(current_path).to eq root_path
      expect(page).to have_content "ログアウトしました"
      expect(page).to_not have_selector ".dropdown", text: user.user_name

      # 複数のウィンドウでのログアウトを想定する
      delete logout_path
      expect(current_path).to eq root_path
      expect(page).to have_content "ログアウトしました"
      expect(page).to_not have_selector ".dropdown", text: user.user_name
    end
  end
end
