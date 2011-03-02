require 'spec_helper'

describe Image do
  before do
    @image = Factory(:image)
  end

  it "render" do
    @image.render("ACube")
    @image.data.should_not be_nil
  end
end
