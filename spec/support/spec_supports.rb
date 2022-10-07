module SpecSupports
  def user_login
    visit login_path
    fill_in "メールアドレス", with: user.mail
    fill_in "パスワード", with: "password"
    check "次回から自動でログイン"
    find("#login").click
    user.reload
  end
end
