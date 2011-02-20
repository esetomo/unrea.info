class AppearancesController < ApplicationController
  def index
    @appearances = Appearance.all
  end

  def show
    @appearance = Appearance.find(params[:id])
    respond_to do |format|
      format.html 
      format.jpg { send_data(@appearance.image, :type => 'image/jpeg') }
    end
  end

  def new
    @appearance = Appearance.new
    @appearance.key = SecureRandom.base64(12)
    @appearance.render
    @appearance.save!
    redirect_to appearance_edit_path(@appearance, @appearance.key)
  end

  def edit
    @appearance = Appearance.find(params[:appearance_id])
    raise "Illigal Key" unless params[:key] == @appearance.key
  end

  def update
    @appearance = Appearance.find(params[:id])
    if @appearance.update(params[:appearance])
      redirect_to appearance_path(@appearance)
    else
      render :action => "edit"
    end
  end
end
