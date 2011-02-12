class UserInfo
  include Mongoid::Document

  embedded_in :user, :inverse_of => :info
end
