# -*- mode:ruby; coding:utf-8 -*-
source 'http://rubygems.org'

gem 'rails', '3.0.3'
gem 'pg'

gem 'rails3-generators'
gem 'jquery-rails'
gem 'i18n_generators'
gem 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git', :branch => 'rails3'
gem 'bson_ext'
gem 'mongo'

gem 'haml'
gem 'haml-rails'

gem 'authlogic'
gem 'oauth'
gem 'authlogic-oauth'

group :development do
  gem "rails-erd"
end

group :development, :test do
  gem "rspec"
  gem "rspec-rails"
  gem "rspec-integration"
  gem "factory_girl_rails"

  gem "ZenTest"
  gem "redgreen"
  gem "diff-lcs"
  gem "webrat"
 
  gem 'cucumber'
  gem 'cucumber-rails'
end

case RUBY_VERSION
when /^1\.9/
  gem 'test-unit', '1.2.3'
end

