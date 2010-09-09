# -*- coding: utf-8 -*-
class OauthsController < ApplicationController
  def verify
    callback_url = url_for :action => :callback
    request_token = Twitter.consumer.get_request_token(:oauth_callback => callback_url)
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end

  def callback
    request_token = OAuth::RequestToken.new(Twitter.consumer,
                                            session[:request_token],
                                            session[:request_token_secret])
    access_token = request_token.get_access_token({},
                                                  :oauth_token => params[:oauth_token],
                                                  :oauth_verifier => params[:oauth_verifier])
    res = Twitter.consumer.request(:get,
                                   '/account/verify_credentials.json',
                                   access_token, {:scheme => :query_string})
    
    case res
    when Net::HTTPSuccess
      user_info = JSON.parse(res.body)
      unless user_info['screen_name']
        flash[:notice] = 'Twitterの認証に失敗しました。'
      else
        session[:access_token] = access_token.token
        session[:secret_token] = access_token.secret
        flash[:notice] = 'Twitterの認証に成功しました。'
        
        mod = OAuthActiveResource.register(OauthsController, Twitter, {:access_token => access_token})
        render :text => mod.Status.friends.inspect
      end
    else
      flash[:notice] = 'Twitterの認証に失敗しました。'
    end
  end
end
