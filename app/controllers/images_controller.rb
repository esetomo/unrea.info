class ImagesController < ApplicationController
  def show
    @image = Image.render(params[:command])
    send_data(@image.data, :type => 'image/png', :disposition => 'inline')
  end
end
