class User < ActiveRecord::Base
  ActiveSupport::Deprecation.silence do # Base.named_scope has been deprecated.
    acts_as_authentic
  end

  has_many :posts

  def twitter
    unless @twitter
      @twitter = Twitter::Client.new(:oauth_token => oauth_token,
                                     :oauth_token_secret => oauth_secret)
    end
    @twitter
  end
end
