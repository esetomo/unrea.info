class Appearance
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :user, :inverse_of => :appearances
end
