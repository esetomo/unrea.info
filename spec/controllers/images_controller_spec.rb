require 'spec_helper'

describe ImagesController do
  describe "GET show" do
    it "should be image/png" do
      get :show, :command => "foo", :format => 'png'
      response.should be_success
      response.content_type.should == "image/png"
    end
  end
end
