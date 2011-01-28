class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  layout nil

  def new
    @user_session = UserSession.new
    redirect_to @user_session.authorize_url(url_for(:action => :create))
  end

  def create
    @user_session = UserSession.new(params)
    if @user_session.save
      flash[:notice] = t("Login successful!")
      # redirect_back_or_default root_url
    else
      flash[:notice] = t("Login failed!")
      # redirect_back_or_default root_url
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = t("Logout successful!")
    redirect_back_or_default new_user_session_url
  end

private
  def authorize_url
  end
end
