require File.expand_path("../foundation.rb", __FILE__)

require File.expand_path("../bundler.rb", __FILE__)
require 'capistrano/rails'

require File.expand_path("../passenger.rb", __FILE__)
require File.expand_path("../whenever.rb", __FILE__)
# require File.expand_path("../daemons.rb", __FILE__)
# require File.expand_path("../cache.rb", __FILE__)

namespace :load do
  task :defaults do
    set :rails_env, "production"
  end
end
