require 'spec_helper'

describe UserSessionsController do
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "with user is logged in" do
    before(:each) do
      activate_authlogic
      Factory.create(:user)
      UserSession.create!({:login => 'testuser', :password => 'testpass'})
    end

    describe "GET 'new'" do
      it "should be successful" do
        get 'new'
        response.should redirect_to(root_path)
      end
    end

    describe "GET 'create'" do
      it "should be successful" do
        get 'create'
        response.should redirect_to(root_path)
      end
    end

    describe "GET 'destroy'" do
      it "should be successful" do
        get 'destroy'
        response.should redirect_to(new_user_session_path)
      end
    end
  end
end
