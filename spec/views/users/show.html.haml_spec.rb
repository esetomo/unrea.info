require 'spec_helper'

describe "users/show.html.haml" do
  before(:each) do
    # @user = assign(:user, stub_model(User))
    @user = Factory(:user)
  end

  it "renders attributes in <p>" do
    render
  end
end
