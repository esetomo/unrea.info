# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.twitter_id '12345'
  f.screen_name 'testuser'
end

Factory.define :admin_user, :class => User do |f|
  f.twitter_id '54895358'
  f.screen_name '15my'
end
