# -*- coding: utf-8 -*-
class WelcomeController < ApplicationController
  def index
    if current_user
      # @tweets = current_user.twitter.friends_timeline
    end
  rescue Twitter::Unauthorized
    current_user_session.destroy
    redirect_to root_url
  end
end
