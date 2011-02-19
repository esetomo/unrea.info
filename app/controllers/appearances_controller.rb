class AppearancesController < ApplicationController
  def show
    respond_to do |format|
      format.html { render :text => '' }
      format.jpg { render :text => '' }
    end
  end
end
