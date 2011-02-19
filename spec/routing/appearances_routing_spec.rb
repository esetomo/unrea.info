require "spec_helper"

describe AppearancesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/u/foo/a" }.should route_to(:controller => "appearances",
                                             :action => "index",
                                             :screen_name => "foo")
    end

    it "recognizes and generates #show" do
      { :get => "/u/foo/a/123" }.should route_to(:controller => "appearances", 
                                                 :action => "show",
                                                 :screen_name => "foo",
                                                 :id => "123")
    end

    it "recognizes and generates #new" do
      { :get => "/u/foo/a/new" }.should route_to(:controller => "appearances",
                                                 :action => "new",
                                                 :screen_name => "foo")
    end

    it "recognizes and generates #create" do
      { :post => "/u/foo/a" }.should route_to(:controller => "appearances",
                                              :action => "create",
                                              :screen_name => "foo")
    end

    it "recognizes and generates #edit" do
      { :get => "/u/foo/a/123/edit" }.should route_to(:controller => "appearances",
                                                      :action => "edit",
                                                      :screen_name => "foo",
                                                      :id => "123")
    end

    it "recognizes and generates #update" do
      { :put => "/u/foo/a/123" }.should route_to(:controller => "appearances",
                                                 :action => "update",
                                                 :screen_name => "foo",
                                                 :id => "123")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/u/foo/a/123" }.should route_to(:controller => "appearances",
                                                    :action => "destroy",
                                                    :screen_name => "foo",
                                                    :id => "123")
    end
  end
end
