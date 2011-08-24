# -*- Ruby -*-
require './init'

task :default => [:spec, :checklinks]

desc 'Prepare test'
task 'test:prepare' => 'db:migrate' do
  Lokka::Database.new.connect.seed
end

desc 'Migrate the Lokka database'
task 'db:migrate' do
  puts 'Upgrading Database...'
  Lokka::Database.new.connect.migrate
end

desc 'Execute seed script'
task 'db:seed' do
  puts 'Initializing Database...'
  # DataMapper::Logger.new(STDOUT, :debug)
  # DataMapper.logger.set_log STDERR, :debug, "SQL: ", true
  Lokka::Database.new.connect.seed
end

desc 'Delete database'
task 'db:delete' do
  puts 'Delete Database...'
  Lokka::Database.new.connect.migrate!
end

desc 'Reset database'
task 'db:reset' => %w(db:delete db:seed)

desc 'Set database'
task 'db:setup' => %w(db:migrate db:seed)

desc 'Install gems'
task :bundle do
  `bundle install --path vendor/bundle --without production test`
end

desc 'Install'
task :install => %w(bundle db:setup)

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = 'spec/*_spec.rb'
    spec.rspec_opts = ['-cfs']
  end
rescue LoadError => e
end

require 'mechanize'

def check_page(agent, uri)
  print uri, "\n"

  page = agent.get(uri)
  case page
  when Mechanize::Page
    page.links.each do |link|
      link_uri = uri + link.uri
      link_uri.fragment = nil
      
      case link_uri
      when URI::HTTP
        unless agent.history.visited?(link_uri)
          case link_uri.host      
          when uri.host
            check_page(agent, link_uri)
          end
        end
      end
    end
  end
end

task :checklinks do
  port = rand(10000) + 10000

  Thread.new do
    Lokka::App.run! :port => port
  end

  agent = Mechanize.new
  top_url = URI.parse("http://localhost:#{port}/")

  begin
    agent.get(top_url)
  rescue Net::HTTP::Persistent::Error
    sleep 1
    retry
  end

  check_page(agent, top_url)
end
