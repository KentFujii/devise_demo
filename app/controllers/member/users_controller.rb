class Member::UsersController < Member::Base
  skip_before_action :touch_profile
  def edit
    @user = current_user
  end
end
