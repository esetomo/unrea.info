class Appearance
  include Mongoid::Document
  include Mongoid::Timestamps

  field :key, :type => String
  references_many :wears

  referenced_in :user, :inverse_of => :appearances

  def image
    self['image']
  end

  def image=(value)
    self['image'] = BSON::Binary.new(value)
  end

  def has_item(item)
    !! wears.where(:item_id => item.id).first
  end

  def render
    if Rails.env == 'test'
      self.image = "dummy"
      return
    end

    work_dir = Rails.root.join('tmp', UUIDTools::UUID.timestamp_create.to_s)
    work_dir.mkdir

    open(work_dir.join("Camera.tga"), "w") do |w|
    end      
    
    wears.each do |wear|
      open(work_dir.join("#{wear.item.name}.tga"), "w") do |w|
      end      
    end

    ENV['WORK_DIR'] = work_dir.to_s
    render_script = Rails.root.join('lib', 'render', 'render.py')
    system("/home/s-tomo/Applications/blender/blender -noaudio -b -P #{render_script}")
    
    open(work_dir.join('result.jpg'), "rb") do |r|
      self.image = r.read
    end

    work_dir.rmtree    
  end
end
