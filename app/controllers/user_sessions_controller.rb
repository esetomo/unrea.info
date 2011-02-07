class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

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
