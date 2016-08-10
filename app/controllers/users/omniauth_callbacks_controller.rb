class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from :facebook
  end

  def linkedin
    callback_from :linkedin
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    @user = User.authenticate_for_oauth(request.env['omniauth.auth'])
    session["user_id"] = @user.id
    redirect_to edit_member_user_path(@user)
  end
end
