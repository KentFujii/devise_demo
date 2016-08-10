class Member::Base < ApplicationController
  before_action :authorize
  before_action :touch_profile

  def authorize
    unless current_user
      flash.alert = 'ログインしてください。'
      return redirect_to :member_root
    end
  end

  def touch_profile
    if current_user && current_user.profile_delivered == false
      flash.alert = 'プロフィールを入力してください。'
      redirect_to edit_member_user_path(current_user)
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
