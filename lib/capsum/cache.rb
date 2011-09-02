require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  
  namespace :rails do
    namespace :cache do

      desc "run Rails.cache.clear"
      task :clear do
        cmds = [
          "cd #{current_path};",
          "if [ -x script/runner ]; then",
            "script/runner 'Rails.cache.clear' -e #{rails_env};",
          "elif [ -x script/rails ]; then",
            "script/rails runner 'Rails.cache.clear' -e #{rails_env};",
          "else",
            "echo Rails runner not found or not executable! && exit 1;",
          "fi"
        ]
        run cmds.join(" ")
      end
      
    end
  end
  
end