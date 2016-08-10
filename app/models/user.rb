class User < ActiveRecord::Base
  attr_accessor :password
  devise :omniauthable

  has_many :emails, dependent: :destroy
  accepts_nested_attributes_for :emails

  after_update :is_profile_delivered?

  def is_profile_delivered?
    # TODO: 必要なプロフィール欄が全て埋まった場合に
    # profile_deliveredをtrueにするcallback処理
  end

  def self.authenticate_for_oauth(auth)
    email = Email.find_by(address: auth.info.email)
    if email
      user = email.user
    else
      user = self.create(
        name: auth.info.name
      )
      Email.create(
        user:     user,
        address:  self.get_email(auth),
        provider: auth.provider,
        uid:      auth.uid
      )
    end
    user
  end

  def authenticate_for_new_comer

  end

  def self.authenticate(params)
    user = Email.find_by(address: params["emails_attributes"]["0"]["address"]).user
    if user && user.hashed_password.present? && BCrypt::Password.new(user.hashed_password) == params[:password]
      user
    else
      nil
    end
  end

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
