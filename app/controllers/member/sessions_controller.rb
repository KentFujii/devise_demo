class Member::SessionsController < Member::Base
  skip_before_action :authorize
  before_action :set_new_user, :redirect_to_top

  def index
  end

  def new
  end

  def create_session
    if user = User.authenticate(user_params)
      session['user_id'] = user.id
      redirect_to :member_users
    else
      flash.alert = 'ログインに失敗しました。'
      render action: 'index'
    end
  end

  def create_user
    @user.assign_attributes(user_params)
    if @user.save
      session['user_id'] = @user.id
      redirect_to :member_users
    else
      flash.alert = 'ユーザー登録に失敗しました。'
      render action: 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation
    )
  end

  def redirect_to_top
    if current_user
      redirect_to :member_users
    end
  end

  def set_new_user
    @user = User.new
  end
end
