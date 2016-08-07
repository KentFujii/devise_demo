class Member::SessionsController < Member::Base
  skip_before_action :authorize

  def new
    if current_user
      redirect_to :member_users_path
    end
  end
end
