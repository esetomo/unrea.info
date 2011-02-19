class Appearance
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :user, :inverse_of => :appearances

  def image
    self['image']
  end

  def image=(value)
    self['image'] = BSON::Binary.new(value)
  end

  def render
    work_dir = Rails.root.join('tmp', UUIDTools::UUID.timestamp_create.to_s)
    work_dir.mkdir
    
    open(work_dir.join('Camera.tga'), "w") do |w|
    end

    open(work_dir.join('Lamp.tga'), "w") do |w|
    end

    open(work_dir.join('Cube.tga'), "w") do |w|
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
