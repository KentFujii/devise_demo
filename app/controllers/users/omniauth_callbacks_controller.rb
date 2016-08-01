class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    p 'aaa' * 100
    callback_from :facebook
  end

  def twitter
    callback_from :twitter
  end

  def google_oauth2
    p 'aaa' * 100
    callback_from :google_oauth2
  end

  private
    def callback_from(provider)
      # p 'xxx' * 100
      provider = provider.to_s
      @user = User.find_for_oauth(request.env['omniauth.auth'])
      if @user.persisted?
        cookies.permanent[:xxx_logined] = { value: @user.created_at }
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
        # p 'aaa' * 100
        sign_in_and_redirect @user, event: :authentication
      else
        if provider == 'twitter'
          session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
        elsif provider == 'facebook'
          session["devise.facebook_data"] = request.env["omniauth.auth"]
        else
          session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
        end
        # p 'bbb' * 100
        redirect_to new_user_registration_url
      end
    end
end
