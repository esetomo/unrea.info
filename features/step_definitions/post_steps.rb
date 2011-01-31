Given /^I am logged in as the admin$/ do
  Twitter.api_endpoint = 'www.example.com/dummy_twitter'
  visit "/user_session?login_with_twitter=1"
  click_link "Allow"
end

Given /^the following posts:$/ do |posts|
  Post.create!(posts.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) post$/ do |pos|
  visit posts_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_button "Destroy"
  end
end

Then /^I should see the following posts:$/ do |expected_posts_table|
  expected_posts_table.diff!(tableish('table tr', 'td,th'))
end
