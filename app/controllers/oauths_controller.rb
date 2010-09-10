# -*- coding: utf-8 -*-
class OauthsController < ApplicationController
  CONSUMER_TOKEN = 'VW0bNP19ZFhA5k1tW3RhA'
  CONSUMER_SECRET = 'HSrt4RcTESzW0Z2XPVS2N7tWoznmB9aT96jBTjCrsI'

  def verify
    oauth = Twitter::OAuth.new(CONSUMER_TOKEN, CONSUMER_SECRET)
    request_token = oauth.request_token(:oauth_callback => url_for(:action => :callback))
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end

  def callback
    oauth = Twitter::OAuth.new('VW0bNP19ZFhA5k1tW3RhA',
                               'HSrt4RcTESzW0Z2XPVS2N7tWoznmB9aT96jBTjCrsI')
    request_token = OAuth::RequestToken.new(oauth.consumer,
                                            session[:request_token],
                                            session[:request_token_secret])
    access_token = request_token.get_access_token({},
                                                  :oauth_token => params[:oauth_token],
                                                  :oauth_verifier => params[:oauth_verifier])

    oauth.authorize_from_access(access_token.token, access_token.secret)        
    client = Twitter::Base.new(oauth)
    user_info = client.verify_credentials
    
    unless user_info['screen_name']
      flash[:notice] = 'Twitterの認証に失敗しました。'
    else
      session[:access_token] = access_token.token
      session[:secret_token] = access_token.secret
      flash[:notice] = 'Twitterの認証に成功しました。'
      
      @tweets = client.friends_timeline
      raise @tweets.inspect
    end
  end
end
