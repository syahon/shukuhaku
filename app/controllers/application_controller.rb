class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end
end
