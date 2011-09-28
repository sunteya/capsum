require File.expand_path("../../capsum.rb", __FILE__)

Capistrano::Configuration.instance(true).load do

  namespace :bundle do

    desc <<-DESC
      Install the current Bundler environment.
      set :bundle_flags,    "--deployment --quiet"
      set :bundle_without,  [:development, :test]
    DESC
    task :install, :except => { :no_release => true } do
      bundle_flags = fetch(:bundle_flags, '')
      bundle_without = fetch(:bundle_without, [:development, :test])
      
      args = []
      args << bundle_flags.to_s
      args << "--without #{bundle_without.join(" ")}" unless bundle_without.empty?
      cmd = "bundle install #{args.join(' ')}"
      
      run "cd #{release_path}; [ -f Gemfile ] && #{cmd}"
    end
  end

  after "deploy:symlink_shared", "bundle:install"

end

