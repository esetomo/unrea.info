class Wear
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :appearance, :inverse_of => :wears
  referenced_in :item, :inverse_of => :wears

  def image
    self['image']
  end

  def image=(value)
    self['image'] = BSON::Binary.new(value)
  end
end