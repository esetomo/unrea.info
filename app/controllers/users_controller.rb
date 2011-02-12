class UsersController < ApplicationController
  before_filter :require_no_user, :only => :login
  before_filter :require_user, :only => :logout
  
  def login
    request_token = signing_consumer.get_request_token(:oauth_callback => callback_url)
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url      
  end

  def callback
    request_token = OAuth::RequestToken.new(signing_consumer,
                                            session[:request_token],
                                            session[:request_token_secret])
    access_token = request_token.get_access_token({},
                                                  :oauth_token => params[:oauth_token],
                                                  :oauth_verifier => params[:oauth_verifier])
    session[:token] = UUIDTools::UUID.random_create.to_s
    user = User.create!(:session_token => session[:token],
                       :oauth_token => access_token.token,
                       :oauth_secret => access_token.secret)
    user_info = user.twitter.verify_credentials
    
    redirect_to root_url
  end

  def logout
    current_user.token = nil
    current_user.save!
    redirect_to root_path
  end

private
  def signing_consumer
    @signing_consumer ||= OAuth::Consumer.new(Twitter.options[:consumer_key],
                                              Twitter.options[:consumer_secret],
                                              :site => 'https://api.twitter.com',
                                              :authorize_url => 'https://api.twitter.com/oauth/authorize')
  end
end
