class Appearance
  include Mongoid::Document
  include Mongoid::Timestamps

  field :key, :type => String
  references_many :wears

  referenced_in :user, :inverse_of => :appearances

  def has_item(item)
    !! wears.where(:item_id => item.id).first
  end

  def self.render_image(command)
    if Rails.env == 'test'
      return "dummy"
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
    blender = "/home/s-tomo/Applications/blender/blender"
    unless File.exists?(blender)
      blender = "/Users/esetomo/Downloads/blender-2/blender.app/Contents/MacOS/blender"
    end
    system("#{blender} -noaudio -b -P #{render_script}")
    
    open(work_dir.join('result.png'), "rb") do |r|
      result = r.read
    end

    work_dir.rmtree    

    return result
  end
end
