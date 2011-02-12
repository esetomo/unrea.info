require 'spec_helper'

def World(m)
  include m
end

require File.expand_path(Rails.root.to_s + '/features/support/fakeweb_helpers.rb')

describe UsersController do
  before do
    stub_post('https://api.twitter.com/oauth/request_token', 'access_token')
    stub_post('https://api.twitter.com/oauth/access_token', 'access_token')
    stub_get('https://api.twitter.com/1/account/verify_credentials.json', 'veryfy_credentials.json')
    stub_get('https://api.twitter.com/1/users/profile_image/15my.json?size=bigger', 'veryfy_credentials.json')
    stub_get('https://api.twitter.com/1/users/profile_image/15my.json?size=mini', 'veryfy_credentials.json')
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      User.stub(:where).with(:screen_name => "foo37") { [mock_user] }
      get :show, :screen_name => "foo37"
      assigns(:user).should be(mock_user)
    end
  end

  describe "GET login" do
    it "redirect to twitter auth" do
      get :login
      response.should be_redirect
    end
  end

  describe "GET logout" do
    it "redirect to root url" do
      controller.session[:token] = 'dummy token'
      get :logout
      response.should redirect_to(root_path)
      # controller.session[:token].should be_nil
    end
  end

  describe "GET callback" do
    it "redirect to root url" do
      get :callback
      response.should redirect_to(root_path)
    end
  end
end
