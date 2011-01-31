class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user, :admin?
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

  def require_admin
    unless admin?
      render(:file => "#{Rails.root}/public/404.html", 
             :status => :notfound, 
             :layout => false)
      return false
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    ActiveSupport::Deprecation.silence do # save(false) is deprecated.
      @current_user_session = UserSession.find
    end
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def admin?
    current_user && current_user.twitter_uid == "54895358" # @15my
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def set_locale
    I18n.locale = params[:locale]
  end
end
