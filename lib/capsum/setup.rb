require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do
  namespace :capsum do
    desc 'upload example files to server on deploy:setup'
    task :setup do
      Dir["**/*.example", "**/*.sample"].each do |source|
        target_dir = File.join(shared_path, File.dirname(source))
        target_file = File.basename(source, ".*")
        
        run "mkdir -p '#{target_dir}'"
        top.upload(source, File.join(target_dir, target_file))
      end
    end
  end
  
  after "deploy:setup", "capsum:setup"
end
