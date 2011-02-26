class UserAppearancesController < ApplicationController
  before_filter :require_user_match, :except => [:index, :show]

  def index
    @appearances = user.appearances
  end

  def show
    @appearance = user.appearances.find(params[:id])
  end

  def new
    @appearance = user.appearances.new
    @appearance.save!
    redirect_to :action => :edit, :id => @appearance.id
  end

  def destroy
    @appearance = user.appearances.find(params[:id])
    @appearance.destroy

    redirect_to :action => :index
  end

  def edit
    @appearance = user.appearances.find(params[:id])
  end

  def update
    @appearance = user.appearances.find(params[:id])
    if @appearance.update(params[:appearance])
      redirect_to user_appearance_path(user.screen_name, @appearance)
    else
      render :action => "edit"
    end
  end
private
  def user
    unless @user
      @user = User.where(:screen_name => params[:screen_name]).first
      raise ActiveRecord::RecordNotFound.new("User not found with screen name #{params[:screen_name]}") unless @user
    end
    return @user
  end
end
