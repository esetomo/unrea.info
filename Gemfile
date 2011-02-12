# -*- mode:ruby; coding:utf-8 -*-
source 'http://rubygems.org'

gem 'rails'
gem 'pg'

gem 'rails3-generators'
gem 'jquery-rails'
gem 'i18n_generators'
gem 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git', :branch => 'rails3'
gem 'bson_ext'
gem 'mongoid', '>= 2.0.0.rc'

gem 'haml'
gem 'haml-rails'

gem 'oauth'
gem 'twitter'
gem 'uuidtools'

group :development do
  gem "rails-erd"
end

group :test do
  gem "rspec"
  gem "rspec-integration"
  gem "factory_girl_rails"
  gem "spork"
  gem "remarkable_mongoid"

  gem "ZenTest"
  gem "redgreen"
  gem "diff-lcs"
 
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'webrat'
  gem 'database_cleaner'
  gem 'fakeweb'
  gem 'net-http-spy'
end

group :test, :development do
  gem "rspec-rails"
end

case RUBY_VERSION
when /^1\.9/
  gem 'test-unit', '1.2.3'
end

