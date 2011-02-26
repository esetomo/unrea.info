namespace :images do
  task :clean => :environment do
    Image.delete_all
  end
end