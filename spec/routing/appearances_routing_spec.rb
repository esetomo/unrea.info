require "spec_helper"

describe AppearancesController do
  describe "routing" do
    it "recognizes and generates #render" do
      { :get => "/render" }.should route_to(:controller => "appearances", :action => "render")
    end
  end
end
