def admin_user
  @admin_user ||= Factory :admin_user
end

def admin_login
  admin_user
  stub_post('https://api.twitter.com/oauth/request_token', 'access_token')
  stub_post('https://api.twitter.com/oauth/access_token', 'access_token')
  stub_get('https://api.twitter.com/1/account/verify_credentials.json', 'veryfy_credentials.json')
  stub_get('https://api.twitter.com/1/users/profile_image/15my.json?size=bigger', 'profile_image.json')
  stub_get('https://api.twitter.com/1/users/profile_image/15my.json?size=mini', 'profile_image.json')

  visit path_to("the login page")
  visit callback_path(:oauth_token => 'OT', :oauth_verifier => 'OV')
end

Given /^I am logged in as the admin$/ do
  admin_login
end

When /^I login as the admin$/ do
  admin_login
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
