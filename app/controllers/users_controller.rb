class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.default_image
    if @user.save
      log_in(@user)
      flash[:success] = "アカウントを登録しました"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "アカウントを更新しました"
      redirect_to @user
    else
      if params[:commit] == "更新"
        keep_only_profile
        render 'show'
      else
        render 'edit'
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントを削除しました"
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :mail, :password, :password_confirmation, :image, :profile)
    end

    def keep_only_profile
      @user.reload
      @user.profile = params[:user][:profile]
    end
end
