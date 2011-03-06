class ImagesController < ApplicationController
  def show
    Image.render(params[:command])
    redirect_to "http://unrea.s3.amazonaws.com/#{params[:command]}.png"
  end
end
