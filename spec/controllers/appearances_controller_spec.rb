require 'spec_helper'

describe AppearancesController do
  describe "GET show" do
    it "should be success" do
      get :show, :screen_name => 'test_user', :id => 123
      response.should be_success
    end

    describe "format jpeg" do
      it "should be image/jpeg" do
        get :show, :screen_name => 'test_user', :id => 123, :format => 'jpg'
        response.should be_success
        response.content_type.should == "image/jpeg"
      end
    end
  end
end
