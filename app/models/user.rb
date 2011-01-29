class User < ActiveRecord::Base
  acts_as_authentic

  def self.oauth_consumer
    Twitter::OAuth.new('VW0bNP19ZFhA5k1tW3RhA',
                       'HSrt4RcTESzW0Z2XPVS2N7tWoznmB9aT96jBTjCrsI')
  end

  def twitter
    unless @twitter
      oauth = User.oauth_consumer
      oauth.authorize_from_access(self.oauth_token, self.oauth_secret)        
      @twitter = Twitter::Base.new(oauth)
    end
    @twitter
  end
end
