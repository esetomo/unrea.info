class Image
  include Mongoid::Document
  field :command, :type => String

  def data
    self['data']
  end

  def data=(value)
    self['data'] = BSON::Binary.new(value)
  end

  def self.render(command)
    image = where(:command => command).first
    return image if image

    image = new(:command => command)
    image.render(command)
    image.save!
    return image
  end

  def render(arg)
    return if Rails.env == 'test'

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
    src = Rails.root.join('lib', 'render', 'lib1.blend')
    blender = "/home/s-tomo/Applications/blender/blender"
    unless File.exists?(blender)
      blender = "/Users/esetomo/Downloads/blender-2/blender.app/Contents/MacOS/blender"
    end
    system("#{blender} -noaudio -b -P #{render_script} #{src}")
    
    open(work_dir.join('result.png'), "rb") do |r|
      self.data = r.read
    end

    work_dir.rmtree    
  end
end
