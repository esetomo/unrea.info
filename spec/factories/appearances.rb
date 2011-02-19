Factory.define :appearance do |f|
  f.id 123
  f.user {
    Factory(:user)
  }
end
