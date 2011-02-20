require 'spec_helper'

describe AppearancesController do
  def mock_appearance(stubs={})
    @mock_appearance ||= mock_model(Appearance, stubs).as_null_object
  end

  def mock_item(stubs={})
    @mock_item ||= mock_model(Item, stubs).as_null_object
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

  describe "POST render" do
    it "should be success" do
      Appearance.stub(:find).with("123"){ mock_appearance }
      post :render_image, :id => "123"
      response.should be_success
    end
  end
end
