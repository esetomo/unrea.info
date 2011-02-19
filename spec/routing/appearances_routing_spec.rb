require "spec_helper"

describe AppearancesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/appearances" }.should route_to(:controller => "appearances",
                                                 :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/appearances/123" }.should route_to(:controller => "appearances", 
                                                     :action => "show",
                                                     :id => "123")
    end

    it "recognizes and generates #new" do
      { :get => "/appearances/new" }.should route_to(:controller => "appearances",
                                                     :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/appearances" }.should route_to(:controller => "appearances",
                                                  :action => "create")
    end

    it "recognizes and generates #edit" do
      { :get => "/appearances/123/edit" }.should route_to(:controller => "appearances",
                                                          :action => "edit",
                                                          :id => "123")
    end

    it "recognizes and generates #update" do
      { :put => "/appearances/123" }.should route_to(:controller => "appearances",
                                                     :action => "update",
                                                     :id => "123")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/appearances/123" }.should route_to(:controller => "appearances",
                                                        :action => "destroy",
                                                        :id => "123")
    end
  end
end
