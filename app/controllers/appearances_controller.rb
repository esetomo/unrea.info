class AppearancesController < ApplicationController
  def index
    @appearances = Appearance.all
  end

  def show
    @appearance = Appearance.find(params[:id])
  end

  def new
    @appearance = Appearance.new
    @appearance.key = SecureRandom.hex(12)
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
    @item = Item.find(params[:item_id])
    @appearance.wears.create(:item => @item)
    render :update do |page|
      page["#item_#{@item.name}"].html render(:partial => 'item.html.haml', :locals => {:item => @item})
      page['#appearance_image'].attr 'src', @appearance.image_path
    end
  end

  def remove_item
    @appearance = Appearance.find(params[:id])
    @item = Item.find(params[:item_id])
    @appearance.wears.destroy_all(:conditions => {:item_id => @item.id})
    render :update do |page|
      page["#item_#{@item.name}"].html render(:partial => 'item.html.haml', :locals => {:item => @item})
      page['#appearance_image'].attr 'src', @appearance.image_path
    end
  end
end
