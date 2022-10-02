class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "アカウントを登録しました"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :mail, :password, :password_confirmation)
    end
end
