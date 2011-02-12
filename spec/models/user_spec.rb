require 'spec_helper'
require 'remarkable/mongoid'

describe User do
  before do
    @user = Factory(:user)
  end

  it do
    @user.twitter_id.should == "12345"
  end

  it do
    @user.screen_name.should == "testuser"
  end

  it "twitter_id validates uniqueness" do
    should validate_uniqueness_of :twitter_id 
  end

  it "screen_name validates uniqueness" do
    should validate_uniqueness_of :screen_name 
  end
end
