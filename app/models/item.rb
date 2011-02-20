class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  references_many :wares
end
