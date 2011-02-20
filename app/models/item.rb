class Item
  include Mongoid::Document
  include Mongoid::Timestamps

  field :kind, :type => String
  field :name, :type => String

  references_many :wears
end
