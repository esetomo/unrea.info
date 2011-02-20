require 'spec_helper'

describe AppearancesController do
  def mock_appearance(stubs={})
    @mock_appearance ||= mock_model(Appearance, stubs).as_null_object
  end

  describe "GET show" do
    it "should be success" do
      Appearance.stub(:find).with("123"){ mock_appearance }
      get :show, :id => "123"
      response.should be_success
    end

    describe "format jpeg" do
      it "should be image/jpeg" do
        Appearance.stub(:find).with("123"){ mock_appearance }
        get :show, :id => "123", :format => 'jpg'
        response.should be_success
        response.content_type.should == "image/jpeg"
      end
    end
  end
end
