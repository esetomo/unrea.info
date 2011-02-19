class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :session_token, :type => String
  field :oauth_token, :type => String
  field :oauth_secret, :type => String

  field :twitter_id, :type => String
  field :screen_name, :type => String
  embeds_one :info, :class_name => 'UserInfo'
  field :profile_image_bigger, :type => String
  field :profile_image_mini, :type => String

  references_many :appearances

  validates_uniqueness_of :twitter_id
  validates_uniqueness_of :screen_name

  def to_key
    [screen_name]
  end

  def twitter
    unless @twitter
      @twitter = Twitter::Client.new(:oauth_token => oauth_token,
                                     :oauth_token_secret => oauth_secret)
    end
    @twitter
  end
end
