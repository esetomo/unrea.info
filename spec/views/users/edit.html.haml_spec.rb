require 'spec_helper'

describe "users/edit.html.haml" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "MyString",
      :twitter_uid => "MyString",
      :avatar_url => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_path(@user), :method => "post" do
      assert_select "input#user_name", :name => "user[name]"
      assert_select "input#user_twitter_uid", :name => "user[twitter_uid]"
      assert_select "input#user_avatar_url", :name => "user[avatar_url]"
    end
  end
end
