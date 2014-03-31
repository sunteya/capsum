namespace :capsum do
  task :symlink_shared_deprecated do
    if fetch(:shared)
      raise "set :shared is deprecated. use :linked_files or :linked_dirs instead."
    end
  end
end

Rake::Task["deploy:check"].enhance ["capsum:symlink_shared_deprecated"]