require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do

  on :load do
    set :shared_children, shared_children + shared if exists?(:shared)
  end
end
