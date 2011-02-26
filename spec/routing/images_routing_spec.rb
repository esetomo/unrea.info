require "spec_helper"

describe ImagesController do
  describe "routing" do
    it "recognizes and generates #show" do
      { :get => "/i/foobar.png" }.should route_to(:controller => "images", 
                                                  :action => "show", 
                                                  :command => "foobar",
                                                  :format => "png")
    end
  end
end
