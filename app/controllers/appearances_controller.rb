class AppearancesController < ApplicationController
  # caches_page :show, :if => Proc.new { |c| c.request.format.jpg? }

  def show
    respond_to do |format|
      format.html {
        expire_page(url_for(:only_path => true, :format => :jpg))
      }
      format.jpg { respond_to_jpg }
    end
  end

  def respond_to_jpg
    work_dir = Rails.root.join('tmp', UUIDTools::UUID.timestamp_create)
    work_dir.mkdir

    open(work_dir.join('Camera.tga'), "w") do |w|
    end

    open(work_dir.join('Lamp.tga'), "w") do |w|
    end

    open(work_dir.join('Cube.tga'), "w") do |w|
    end

    ENV['WORK_DIR'] = work_dir.to_s
    render_script = Rails.root.join('lib', 'render', 'render.py')
    system("blender -noaudio -b -P #{render_script}")
    result_file = work_dir.join('result.jpg')

    send_file(result_file, :type => 'image/jpg')
    work_dir.rmtree
  end
end
