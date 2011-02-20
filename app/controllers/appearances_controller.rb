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
    redirect_to edit_appearance_path(@appearance, @appearance.key)
  end

  def edit
    @appearance = Appearance.find(params[:id])
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

  def add_item
    @appearance = Appearance.find(params[:id])
    @appearance.wears.create(:item_id => params[:item_id])
    render :update do |page|
      page['#editor'].html render('editor.html.haml')
    end
  end

  def remove_item
    @appearance = Appearance.find(params[:id])
    @appearance.wears.destroy_all(:conditions => {:item_id => params[:item_id]})
    render :update do |page|
      page['#editor'].html render('editor.html.haml')
    end
  end

  def render_image
    @appearance = Appearance.find(params[:id])
    @appearance.render
    @appearance.save!
    render :update do |page|
      page['#editor'].html render('editor.html.haml')
    end    
  end
end
