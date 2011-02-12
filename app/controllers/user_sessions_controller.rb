class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => :login
  before_filter :require_user, :only => :logout

  def login
    request_token = signing_consumer.get_request_token(:oauth_callback => "#{base_url}/callback")
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect request_token.authorize_url      
  end

  def new
    @user_session = UserSession.new
    render :layout => nil
  end

  def create
    @user_session = UserSession.new(params)
    @user_session.save do |result|
      if result
        flash[:notice] = t("Login successful!")
        redirect_back_or_default root_url
      else
        flash[:notice] = t("Login failed!")
        redirect_back_or_default root_url
      end
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = t("Logout successful!")
    redirect_back_or_default root_url
  end
end
