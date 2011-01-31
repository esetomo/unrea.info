# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.login 'testuser'
  f.password 'testpass'
  f.password_confirmation 'testpass'
end

Factory.define :admin_user, :class => User do |f|
  f.login 'admin'
  f.password 'admin'
  f.password_confirmation 'admin'
  f.twitter_uid '54895358'
end
