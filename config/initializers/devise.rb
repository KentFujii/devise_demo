# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  config.omniauth :facebook, '278390139193167', '51074dabc8b43ecdd66c2f0ff506eeea'
  config.omniauth :linkedin, '75w3ljcqdg1pwo', 'DbFAUszKamyh4DAP'
  # config.omniauth :twitter, '	lv4tewj21Ce75ErokGmVI3kPf', 'swpY3EpjprMHAxYv9jY60jErWh8cAS5kkRQPJVa5hLr1MLRjxN'
  # config.omniauth :google_oauth2, '683219775802-0vhgi4rsab0nk10gjagm068sk2i7nkt3.apps.googleusercontent.com', 'taXjZ4KR8CGUQdAIBW8ptwkX'

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
