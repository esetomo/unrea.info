require "spec_helper"

describe PostsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/posts" }.should route_to(:controller => "posts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/posts/new" }.should route_to(:controller => "posts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/posts/1" }.should route_to(:controller => "posts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/posts/1/edit" }.should route_to(:controller => "posts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/posts" }.should route_to(:controller => "posts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/posts/1" }.should route_to(:controller => "posts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/posts/1" }.should route_to(:controller => "posts", :action => "destroy", :id => "1")
    end

    it "toppage" do
      { :get => "/" }.should route_to(:controller => "posts", :action => "index")
    end

    it "list of year" do
      { :get => "/2010" }.should route_to(:controller => "posts", :action => "index_by_year", :year => "2010")
    end

    it "list of month" do
      { :get => "/2010/11" }.should route_to(:controller => "posts", :action => "index_by_month", :year => "2010", :month => "11")
    end

    it "list of day" do
      { :get => "/2010/11/23" }.should route_to(:controller => "posts", :action => "index_by_day", :year => "2010", :month => "11", :day => "23")
    end

    it "post by time" do
      { :get => "/2010/11/23/122316" }.should route_to(:controller => "posts", :action => "show_by_time", :year => "2010", :month => "11", :day => "23", :hour => "12", :min => "23", :sec => "16")
    end
  end
end
