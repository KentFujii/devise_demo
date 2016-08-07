class User < ActiveRecord::Base
  devise :omniauthable

  attr_accessor :password, :password_confirmation

  validates :email, presence: true, uniqueness: true

  def self.find_for_oauth(auth)
    user = self.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = self.create(
        uid: auth.uid,
        provider: auth.provider,
        name: auth.info.name,
        email: self.get_email(auth),
      )
    end
    user
  end

  def self.authenticate(params)
    user = self.find_by(email: params[:email])
    if user && user.hashed_password.present? && BCrypt::Password.new(user.hashed_password) == params[:password]
      user
    else
      nil
    end
  end

  # def create_new_user(params)
  #   self.email = params[:email]
  #   raw_password = params[:password]
  #   if raw_password && raw_password.kind_of?(String)
  #     self.hashed_password = BCrypt::Password.create(raw_password)
  #   end
  #   self.save
  # end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  private

  def self.get_email(auth)
    email = auth.info.email
    email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
    email
  end
end
