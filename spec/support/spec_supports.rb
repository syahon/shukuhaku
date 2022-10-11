module SpecSupports
  def user_login
    visit login_path
    fill_in "メールアドレス", with: user.mail
    fill_in "パスワード", with: "password"
    check "次回から自動でログイン"
    find("#login").click
    user.reload
  end

  def post_login
    post login_path, params: { session: { mail: user.mail, password: "password"}}
  end
end
