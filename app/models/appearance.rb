class Appearance
  include Mongoid::Document
  include Mongoid::Timestamps

  field :key, :type => String
  references_many :wears

  referenced_in :user, :inverse_of => :appearances

  def has_item(item)
    !! wears.where(:item_id => item.id).first
  end

  def image_path
    Rails.application.routes.url_helpers.image_path('_' + wears.map{|wear| wear.to_command }.join('_'), :format => "png")
  end
end
