# -*- coding: utf-8 -*-
class WelcomeController < ApplicationController
  def index 
    redirect_to user_path(current_user.info.screen_name) if current_user
  end
end
