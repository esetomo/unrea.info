# -*- coding: euc-jp -*-
class UserSession < Authlogic::Session::Base
  validate :validate_by_twitter

  def self.oauth_consumer
    Twitter::OAuth.new('VW0bNP19ZFhA5k1tW3RhA',
                       'HSrt4RcTESzW0Z2XPVS2N7tWoznmB9aT96jBTjCrsI')
  end

  def to_key
    new_record? ? nil : [1]
  end

  def authorize_url(callback)
    oauth = UserSession.oauth_consumer
    request_token = oauth.request_token(:oauth_callback => callback)
    controller.session[:request_token] = request_token.token
    controller.session[:request_token_secret] = request_token.secret

    return request_token.authorize_url
  end

  private
  
  def validate_by_twitter
    oauth = UserSession.oauth_consumer

    self.attempted_record = User.where(:oauth_token => controller.session[:oauth_token]).first
    if self.attempted_record
      oauth.authorize_from_access(self.attempted_record.oauth_token,
                                  self.attempted_record.oauth_secret)
      @client = Twitter::Base.new(oauth)
    else
      request_token = OAuth::RequestToken.new(oauth.consumer,
                                              controller.session[:request_token],
                                              controller.session[:request_token_secret])
      access_token = request_token.get_access_token({},
                                                    :oauth_token => controller.params[:oauth_token],
                                                    :oauth_verifier => controller.params[:oauth_verifier])

      oauth.authorize_from_access(access_token.token, access_token.secret)        
      @client = Twitter::Base.new(oauth)
      user_info = @client.verify_credentials

      self.attempted_record = User.find_or_create_by_twitter_uid(:twitter_uid => user_info['id_str'],
                                                                 :oauth_token => access_token.token,
                                                                 :oauth_secret => access_token.secret,
                                                                 :name => user_info['name'],
                                                                 :screen_name => user_info['screen_name'],
                                                                 :avatar_url => user_info['profile_image_url'])
    end
  rescue OAuth::Unauthorized
    errors.add_to_base($!.message)
  end
end
