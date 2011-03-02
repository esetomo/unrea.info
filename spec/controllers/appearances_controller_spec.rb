require 'spec_helper'

describe AppearancesController do
  def mock_appearance(stubs={})
    @mock_appearance ||= mock_model(Appearance, stubs).as_null_object
  end

  def mock_item(stubs={})
    @mock_item ||= mock_model(Item, stubs).as_null_object
  end

  describe "GET index" do
    it "should be success" do
      Appearance.stub(:all){ [mock_appearance] }
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "should be success" do
      Appearance.stub(:find).with("123"){ mock_appearance }
      get :show, :id => "123"
      response.should be_success
    end
  end

  describe "GET new" do
    it "should be redirect to edit" do
      get :new
      response.should redirect_to(edit_appearance_path(assigns(:appearance), assigns(:appearance).key))
    end
  end

  describe "POST add_item" do
    it "should be success" do
      Appearance.stub(:find).with("123"){ mock_appearance }
      Item.stub(:find).with("456"){ mock_item }
      post :add_item, :id => "123", :item_id => "456"
      response.should be_success
    end
  end

  describe "POST remove_item" do
    it "should be success" do
      Appearance.stub(:find).with("123"){ mock_appearance }
      Item.stub(:find).with("456"){ mock_item }
      post :remove_item, :id => "123", :item_id => "456"
      response.should be_success
    end
  end

  describe "GET edit" do
    it "should be success" do
      Appearance.stub(:find).with("123"){ mock_appearance }
      mock_appearance.should_receive(:key).and_return("foobar")
      get :edit, :id => "123", :key => "foobar"
      response.should be_success
    end
  end

  describe "PUT update" do
    it "should redirect to appearance_path" do
      Appearance.stub(:find).with("123"){ mock_appearance }
      put :update, :id => "123"
      response.should redirect_to(mock_appearance)
    end
    
    describe "with illigal params" do
      it "should return to form" do
        Appearance.stub(:find).with("123"){ mock_appearance(:update => false) }
        put :update, :id => "123"
        response.should be_success
        response.should render_template("edit")
      end
    end
  end
end
