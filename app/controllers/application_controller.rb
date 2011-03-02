class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :admin?
  before_filter :set_locale

  private
  def require_user
    unless current_user
      store_location
      flash[:notice] = t("You must be logged in to access this page")
      redirect_to root_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = t("You must be logged out to access this page")
      redirect_to root_url
      return false
    end
  end

=begin
  def require_admin
    unless admin?
      render(:file => "#{Rails.root}/public/404.html", 
             :status => :notfound, 
             :layout => false)
      return false
    end
  end
=end

  def require_user_match
    unless current_user == user
      redirect_to root_url
      return false
    end
  end

  def current_user
    return nil unless session[:token]
    @current_user ||= User.where(:session_token => session[:token]).first
  end

=begin
  def admin?
    current_user && current_user.twitter_id == "54895358" # @15my
  end
=end

  def store_location
    session[:return_to] = request.fullpath
  end

=begin
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
=end

  def set_locale
    I18n.locale = params[:locale]
  end
end
