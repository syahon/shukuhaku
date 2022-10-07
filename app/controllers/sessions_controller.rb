class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(mail: params[:session][:mail].downcase)
    if @user&.authenticate(params[:session][:password])
      log_in(@user)
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      flash[:success] = "ようこそ #{@user.user_name} 様"
      redirect_to root_path
    else
      flash.now[:danger] = "入力したメールアドレスまたはパスワードが間違っています"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end
end
