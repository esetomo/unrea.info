class UserInfo
  include Mongoid::Document

  field :name, :type => String

  embedded_in :user, :inverse_of => :info
end
