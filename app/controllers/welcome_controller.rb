# -*- coding: utf-8 -*-
class WelcomeController < ApplicationController
  def index
    @tweets = current_user.twitter.friends_timeline
  end
end
