class User < ActiveRecord::Base
  acts_as_authentic

  has_many :posts

  def twitter
    unless @twitter
      @twitter = Twitter::Client.new(:oauth_token => oauth_token,
                                     :oauth_token_secret => oauth_secret)
    end
    @twitter
  end
end
