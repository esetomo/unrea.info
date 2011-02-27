namespace :images do
  task :clean => :environment do
    Image.delete_all
  end
end

file 'config/initializers/secret_token.rb' do |t|
  open(t.name, 'w') do |w|
    token = `rake secret`.split(/\n/)[1].chomp
    w.write("Unrea::Application.config.secret_token = '#{token}'\n")
  end
end