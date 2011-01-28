# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.login 'testuser'
  f.password 'testpass'
  f.password_confirmation 'testpass'
end
