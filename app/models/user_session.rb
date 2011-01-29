# -*- coding: euc-jp -*-
class UserSession < Authlogic::Session::Base
  validate :validate_by_twitter, :if => :authenticating_with_twitter?

  def to_key
    if user
      [ user.id ]
    else
      nil
    end
  end

  def save(&block)
    block = nil if redirecting_to_twitter_auth?
    super(&block)
  end

  private

  def authenticating_with_twitter?
    (! controller.params[:login_with_twitter].blank?) ||
      (! controller.params[:oauth_token].blank?)
  end

  def redirecting_to_twitter_auth?
    authenticating_with_twitter? && controller.params[:oauth_token].blank?
  end

  def validate_by_twitter
    if controller.params[:oauth_token].blank?
      redirect_to_twitter_auth
    else
      authenticate_with_twitter
    end
  end

  def redirect_to_twitter_auth
    oauth = User.oauth_consumer
    request_token = oauth.request_token(:oauth_callback => build_callback_url)
    controller.session[:request_token] = request_token.token
    controller.session[:request_token_secret] = request_token.secret
    controller.session[:twitter_callback_method] = controller.request.method
    controller.redirect_to request_token.authorize_url      
  end

  def build_callback_url
    controller.url_for(:controller => controller.controller_name,
                       :action => controller.action_name)
  end

  def record=(record)
    @record = record
  end

  def authenticate_with_twitter
    if @record
      self.attempted_record = @record
      return
    end

    oauth = User.oauth_consumer
    request_token = OAuth::RequestToken.new(oauth.consumer,
                                            controller.session[:request_token],
                                            controller.session[:request_token_secret])
    access_token = request_token.get_access_token({},
                                                  :oauth_token => controller.params[:oauth_token],
                                                  :oauth_verifier => controller.params[:oauth_verifier])

    oauth.authorize_from_access(access_token.token, access_token.secret)        
    client = Twitter::Base.new(oauth)
    user_info = client.verify_credentials

    self.attempted_record = User.find_or_initialize_by_twitter_uid(:twitter_uid => user_info['id_str'])
    self.attempted_record.oauth_token = access_token.token
    self.attempted_record.oauth_secret = access_token.secret
    self.attempted_record.name = user_info['name']
    self.attempted_record.screen_name = user_info['screen_name']
    self.attempted_record.avatar_url = user_info['profile_image_url']
    self.attempted_record.reset_persistence_token
  rescue OAuth::Unauthorized
    errors.add_to_base($!.message)
  end
end
