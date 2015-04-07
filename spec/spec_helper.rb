require 'active_record'
require 'active_support'
require 'database_cleaner'
require 'rack'
require 'pry'
require 'imgix'
require 'imgix/action_view/helpers'
# require 'rspec/rails'

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveSupport.on_load(:active_record) do
  include Imgix::ModelExtensions
end

ActiveSupport.on_load(:action_view) do
  include Imgix::ActionView::Helpers
end

require 'support/models'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
