require 'spec_helper'
require 'remarkable/mongoid'

describe Appearance do
  before do
    @appearance = Factory(:appearance)
  end

  it "screen name should testuser" do
    @appearance.user.screen_name.should == "testuser"
  end

  it "image path should /i/_.png" do
    @appearance.image_path.should == "/i/_.png"
  end

  it "not has item" do
    @item = Factory(:item)
    @appearance.has_item(@item).should be(false)
  end
end
