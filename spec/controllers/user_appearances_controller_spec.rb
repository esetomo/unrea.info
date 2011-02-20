require 'spec_helper'

describe UserAppearancesController do
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET show" do
    it "should be success" do
      User.stub(:where).with(:screen_name => "test_user") { [mock_user] }
      get :show, :screen_name => 'test_user', :id => 123
      response.should be_success
    end

    describe "format jpeg" do
      it "should be image/jpeg" do
        User.stub(:where).with(:screen_name => "test_user") { [mock_user] }
        get :show, :screen_name => 'test_user', :id => 123, :format => 'jpg'
        response.should be_success
        response.content_type.should == "image/jpeg"
      end
    end
  end
end
