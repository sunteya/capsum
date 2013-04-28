require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do

  on :load do
    if exists?(:shared)
      set :shared_children, shared_children + shared 
      warn "[DEPRECATED] 'set :shared, []' is deprecated. Use official 'set :shared_children, shared_children + []' instead."
    end
  end
end
