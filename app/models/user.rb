class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :oauth_token
    c.crypted_password_field = :oauth_secret
  end

  def valid_password?(attempted_password)
    raise
  end
end
