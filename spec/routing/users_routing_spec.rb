require "spec_helper"

describe UsersController do
  describe "routing" do
    it "recognizes and generates #login" do
      { :get => "/login" }.should route_to(:controller => "users", :action => "login")
    end

    it "recognizes and generates #logout" do
      { :get => "/logout" }.should route_to(:controller => "users", :action => "logout")
    end

    it "recognizes and generates #callback" do
      { :get => "/callback" }.should route_to(:controller => "users", :action => "callback")
    end

    it "recognizes and generates #show" do
      { :get => "/u/foo" }.should route_to(:controller => "users", :action => "show", :screen_name => "foo")
    end
  end
end
