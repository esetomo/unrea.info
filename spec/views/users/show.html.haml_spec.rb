require 'spec_helper'

describe "users/show.html.haml" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "Name",
      :twitter_uid => "Twitter Uid",
      :avatar_url => "Avatar Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Twitter Uid/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Avatar Url/)
  end
end
