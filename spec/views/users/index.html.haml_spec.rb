require 'spec_helper'

describe "users/index.html.haml" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :name => "Name",
        :twitter_uid => "Twitter Uid",
        :avatar_url => "Avatar Url"
      ),
      stub_model(User,
        :name => "Name",
        :twitter_uid => "Twitter Uid",
        :avatar_url => "Avatar Url"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Twitter Uid".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Avatar Url".to_s, :count => 2
  end
end
