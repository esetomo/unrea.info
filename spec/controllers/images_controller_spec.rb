require 'spec_helper'

describe ImagesController do
  def mock_image(stubs={})
    @mock_image ||= mock_model(Image, stubs).as_null_object
  end

  describe "GET show" do
    it "should be image/png" do
      get :show, :command => "foo", :format => 'png'
      response.should be_success
      response.content_type.should == "image/png"
    end
  end
end
