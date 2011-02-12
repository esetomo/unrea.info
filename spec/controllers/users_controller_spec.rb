require 'spec_helper'

describe UsersController do
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
      lambda{ get :callback }.should raise_error(OAuth::Unauthorized)
    end
  end
end
