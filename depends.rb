require "rubygems"
gem "gem_loader", ">= 0.2.0"
require "gem_loader"


GemLoader.setup do

  scope :runtime do
    gem "capistrano", "~> 2.5.19"
    gem "capistrano_colors", "~> 0.5.2", :require => nil
    gem "capistrano-ext", "~> 1.2.1", :require => nil
    gem "capistrano-helpers", "~> 0.4.4", :require => nil
    # gem "cap-recipes", "~> 0.3.36", :require => nil
  end

  scope :optional do
  end
  
  scope :test do
    # gem "rspec", ">= 1.3.0", :require => nil
  end

  scope :development => [:optional, :test]

  scope :rakefile do
    gem "rake", ">= 0.8.7"
    gem "jeweler", ">= 1.4.0"
    # gem "rspec", :require => "spec/rake/spectask"
  end
end
