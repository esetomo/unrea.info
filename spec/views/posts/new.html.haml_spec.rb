require 'spec_helper'

describe "posts/new.html.haml" do
  before(:each) do
    assign(:post, stub_model(Post,
      :title => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new post form" do
    render

    rendered.should have_selector("form", :action => posts_path, :method => "post") do |form|
      form.should have_selector("input#post_title", :name => "post[title]")
      form.should have_selector("textarea#post_content", :name => "post[content]")
    end
  end
end
