# -*- coding: utf-8 -*-
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'spork'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = :mongoid
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end
end

Spork.prefork do
end

Spork.each_run do
end
