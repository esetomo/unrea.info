class Appearance
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActionController::UrlWriter

  field :key, :type => String
  references_many :wears

  referenced_in :user, :inverse_of => :appearances

  def has_item(item)
    !! wears.where(:item_id => item.id).first
  end

  def image_path
    appearance_image_path('_' + wears.map{|wear| wear.to_command }.join('_'))
  end

  def self.render_image(arg)
    if Rails.env == 'test'
      return "dummy"
    end

    work_dir = Rails.root.join('tmp', UUIDTools::UUID.timestamp_create.to_s)
    work_dir.mkdir

    open(work_dir.join("Camera.tga"), "w") do |w|
    end      
    
    commands = arg.split(/_/)
    commands.each do |command|
      case command
      when /A(.+)/
        open(work_dir.join("#{$1}.tga"), "w") do |w|
        end      
      end
    end

    ENV['WORK_DIR'] = work_dir.to_s
    render_script = Rails.root.join('lib', 'render', 'render.py')
    blender = "/home/s-tomo/Applications/blender/blender"
    unless File.exists?(blender)
      blender = "/Users/esetomo/Downloads/blender-2/blender.app/Contents/MacOS/blender"
    end
    system("#{blender} -noaudio -b -P #{render_script}")
    
    result = nil
    open(work_dir.join('result.png'), "rb") do |r|
      result = r.read
    end

    work_dir.rmtree    

    return result
  end
end
