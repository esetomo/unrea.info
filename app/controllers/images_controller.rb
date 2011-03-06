# -*- coding: utf-8 -*-
class ImagesController < ApplicationController
  def show
    command = params[:command]
    obj = nil

    begin
      obj = $bucket.objects.find("#{command}.png")
    rescue S3::Error::NoSuchKey
      obj = render(command)
    end

    redirect_to obj.url
  end

private
  def render(arg)
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
    render_script = Rails.root.join('lib', 'render', 'render.py').to_s
    quit_script = Rails.root.join('lib', 'render', 'quit.py').to_s
    src = Rails.root.join('lib', 'render', 'lib1.blend').to_s
    
    blender = "/home/s-tomo/Applications/blender/blender"
    blender = "/home/ubuntu/Applications/blender/blender" unless File.exists?(blender)
    blender = "/Users/esetomo/Downloads/blender-2/blender.app/Contents/MacOS/blender" unless File.exists?(blender)
    blender = 'D:/Users/s-tomo/Blender Foundation/Blender/blender.exe' unless File.exists?(blender)

    case RUBY_PLATFORM
    when /mswin(?!ce)|mingw|cygwin|bccwin/
      # Windowsではbatchモードだとbpyモジュールがうまく読み込まれない様子
      system(blender, "-P", render_script, "-P", quit_script, src)
    else
      system(blender, "-noaudio", "-b", "-P", render_script, src)
    end
    
    obj = nil
    open(work_dir.join('result.png'), "rb") do |r|
      obj = $bucket.objects.build("#{arg}.png")
      obj.content = r.read
      obj.content_type = 'image/png'
      obj.save
    end

    work_dir.rmtree    

    return obj
  end
end
