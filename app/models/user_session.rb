class UserSession < Authlogic::Session::Base
  CONSUMER_TOKEN = 'VW0bNP19ZFhA5k1tW3RhA'
  CONSUMER_SECRET = 'HSrt4RcTESzW0Z2XPVS2N7tWoznmB9aT96jBTjCrsI'

  def to_key
    new_record? ? nil : [self.send(self.class.primary_key)]
  end

  def self.oauth_consumer
    OAuth::Consumer.new(CONSUMER_TOKEN,
                        CONSUMER_SECRET,
                        :site => 'http://twitter.com',
                        :authorize_url => 'http://twitter.com/oauth/authenticate')
  end
end
