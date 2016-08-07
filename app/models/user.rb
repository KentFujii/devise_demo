class User < ActiveRecord::Base
  devise :omniauthable

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        name: auth.info.name,
        email: User.get_email(auth),
      )
    end
    user
  end

  private

  def self.get_email(auth)
    email = auth.info.email
    email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
    email
  end
end
