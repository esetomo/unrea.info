class User < ActiveRecord::Base
  acts_as_authentic

  CONSUMER_KEY = 'VW0bNP19ZFhA5k1tW3RhA'
  CONSUMER_SECRET = 'HSrt4RcTESzW0Z2XPVS2N7tWoznmB9aT96jBTjCrsI'

  def self.oauth_consumer
    Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
  end

  def twitter
    unless @twitter
      oauth = User.oauth_consumer
      oauth.authorize_from_access(oauth_token, oauth_secret)        
      @twitter = Twitter::Base.new(oauth)
    end
    @twitter
  end
end
