class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :session_token, :type => String
  field :oauth_token, :type => String
  field :oauth_secret, :type => String

  has_many :posts

  def twitter
    unless @twitter
      @twitter = Twitter::Client.new(:oauth_token => oauth_token,
                                     :oauth_token_secret => oauth_secret)
    end
    @twitter
  end
end
