class Member::Base < ApplicationController
  before_action :authorize

  def authorize
    unless current_user
      flash.alert = 'ログインしてください。'
      redirect_to :member_root
    end
  end

  private

  def current_user
    if cookies.signed[:user_id]
      session[:user_id] = cookies.signed[:user_id]
    end
    if session[:user_id]
      @current_user ||=
        User.find_by(id: session[:user_id])
    end
  end

  helper_method :current_user
end
