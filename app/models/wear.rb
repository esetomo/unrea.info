class Wear
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :appearance, :inverse_of => :wears
  referenced_in :item, :inverse_of => :wears

  def to_command
    "A#{item.name}"
  end
end
