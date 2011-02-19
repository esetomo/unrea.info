require 'spec_helper'
require 'remarkable/mongoid'

describe Appearance do
  before do
    @appearance = Factory(:appearance)
  end

  it do
    @appearance.user.screen_name.should == "testuser"
  end
end
