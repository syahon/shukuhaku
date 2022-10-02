require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { build(:user) }

  describe "ユーザーの新規登録" do
    context "無効な値を送信した場合" do
      it "ユーザーの登録に失敗すること" do
        visit sign_up_path

        fill_in "メールアドレス", with: "test@example.com"
        fill_in "パスワード", with: "foo"
        fill_in "パスワード確認", with: "bar"

        click_on "アカウント作成"

        expect(current_path).to_not eq user_path(user)

        within ".error-container" do
          expect(page).to have_content "エラー："
        end
        expect(page).to have_field with: "test@example.com"
      end
    end

    context "有効な値を送信した場合" do
      it "ユーザーの登録に成功すること" do
        visit sign_up_path

        fill_in "名前", with: user.user_name
        fill_in "メールアドレス", with: user.mail
        fill_in "パスワード", with: user.password
        fill_in "パスワード確認", with: user.password_confirmation

        click_on "アカウント作成"

        users = User.all
        expect(users.size).to eq 1
        expect(current_path).to eq user_path(user)
        expect(page).to have_content "アカウントを登録しました"
      end
    end
  end

  describe "ユーザーの登録内容の編集" do
    context "無効な値を送信した場合" do
      it "更新に失敗すること" do
        user.save
        visit user_path(user)
        click_on "編集"

        fill_in "名前", with: " "

        click_on "アカウント更新"

        expect(page).to have_content "エラー："
      end
    end

    context "パスワードとパスワード確認の項目を空の状態で有効な値を送信した場合" do
      it "更新に成功すること" do
        user.save
        visit edit_user_path(user)

        fill_in "名前", with: "hoge"

        click_on "アカウント更新"

        expect(current_path).to eq user_path(user)
        expect(user.reload.user_name).to eq "hoge"
        expect(page).to have_content "アカウントを更新しました"
      end
    end
  end
end
