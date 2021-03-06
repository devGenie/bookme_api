# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'database_cleaner'
require 'support/request_spec_helper'


  # configure shoulder matchers to use rspec as test framework and fullmatcher libraries for rails
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Dir[Rails.root.join('spec/support/**/*.rb')].each{ |f| require f }

RSpec.configure do |config|
  # Add factorygirl methods
  config.include FactoryBot::Syntax::Methods
  config.include RequestSpecHelper, type: :request

  # Truncate all tables but use the fastest transaction
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end 

  # start the transaction strategy as examples are run
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
