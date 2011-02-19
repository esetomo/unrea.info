Factory.define :appearance do |f|
  f.user {
    Factory(:user)
  }
end
