class AppearancesController < ApplicationController
  def index
    @appearances = user.appearances
  end

  def show
    @appearance = user.appearances.find(params[:id])
    respond_to do |format|
      format.html 
      format.jpg { send_data(@appearance.image, :type => 'image/jpg') }
    end
  end

  def new
    @appearance = user.appearances.new
  end

  def create
    @appearance = user.appearances.new(params[:appearance])
    @appearance.render
    @appearance.save!
    redirect_to :action => :index
  end

  def destroy
    @appearance = user.appearances.find(params[:id])
    @appearance.destroy

    redirect_to :action => :index
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
