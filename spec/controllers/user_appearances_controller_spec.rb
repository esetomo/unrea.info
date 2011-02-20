require 'spec_helper'

describe UserAppearancesController do
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  def mock_appearance(stubs={})
    @mock_appearance ||= mock_model(Appearance, stubs).as_null_object
  end

  describe "GET index" do
    it "should be success" do
      User.stub(:where).with(:screen_name => "test_user") { [mock_user] }
      get :index, :screen_name => 'test_user'
      response.should be_success
    end
  end

  describe "GET show" do
    it "should be success" do
      User.stub(:where).with(:screen_name => "test_user") { [mock_user] }
      get :show, :screen_name => 'test_user', :id => 123
      response.should be_success
    end

    describe "format png" do
      it "should be image/png" do
        User.stub(:where).with(:screen_name => "test_user") { [mock_user] }
        get :show, :screen_name => 'test_user', :id => 123, :format => 'png'
        response.should be_success
        response.content_type.should == "image/png"
      end
    end
  end

  describe "GET new" do
    it "should be redirect" do
      User.stub(:where).with(:screen_name => "test_user") { [mock_user] }
      get :new, :screen_name => 'test_user'
      response.should redirect_to(root_path)
    end

    describe "user match" do
      it "should be redirect to edit" do
        session[:token] = 'test_token'
        User.stub(:where).with(:session_token => "test_token") { [mock_user] }
        User.stub(:where).with(:screen_name => "test_user") { [mock_user] }
        mock_user.appearances.stub(:new) { mock_appearance }

        get :new, :screen_name => 'test_user'
        response.should redirect_to(edit_user_appearance_path("test_user", mock_appearance))
      end
    end
  end

  describe "GET edit" do
    it "should be redirect" do
      User.stub(:where).with(:screen_name => "test_user"){[mock_user]}
      mock_user.appearances.stub(:find).with("123"){ mock_appearance }
      
      get :edit, :screen_name => 'test_user', :id => "123"
      response.should redirect_to(root_path)
    end

    describe "user match" do
      it "should be success" do
        session[:token] = 'test_token'
        User.stub(:where).with(:session_token => "test_token") { [mock_user] }
        User.stub(:where).with(:screen_name => "test_user"){[mock_user]}
        mock_user.appearances.stub(:find).with("123"){ mock_appearance }
        
        get :edit, :screen_name => 'test_user', :id => "123"
        response.should be_success
        assigns(:appearance).should be(mock_appearance)
      end
    end
  end

  describe "PUT update" do
    it "should be redirect" do
      User.stub(:where).with(:screen_name => "test_user"){[mock_user]}
      mock_user.appearances.stub(:find).with("123"){ mock_appearance }
      
      put :update, :screen_name => 'test_user', :id => "123"
      response.should redirect_to(root_path)
    end

    describe "user match" do
      it "should be success" do
        session[:token] = 'test_token'
        User.stub(:where).with(:session_token => "test_token") { [mock_user] }
        User.stub(:where).with(:screen_name => "test_user"){[mock_user]}
        mock_user(:screen_name => "test_user").appearances.stub(:find).with("123"){ mock_appearance }
        
        put :update, :screen_name => 'test_user', :id => "123"
        response.should redirect_to(user_appearance_path("test_user", mock_appearance))
      end
    end
  end
end
