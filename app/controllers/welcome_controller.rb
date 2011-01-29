# -*- coding: utf-8 -*-
class WelcomeController < ApplicationController
  def index
    if current_user
      @tweets = current_user.twitter.friends_timeline
    end
  end
end
