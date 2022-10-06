class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(mail: params[:session][:mail].downcase)
    if @user&.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to root_path
    else
      flash.now[:danger] = "入力したメールアドレスまたはパスワードが間違っています"
      render 'new'
    end
  end

  def destroy
  end
end
