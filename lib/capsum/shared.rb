require "capsum"

namespace :capsum do
  task :symlink_shared_deprecated do
    if fetch(:shared)
      raise "set :shared is deprecated. use :linked_files or :linked_dirs instead."
    end
  end
end
Rake::Task["deploy:check"].enhance ["capsum:symlink_shared_deprecated"]

namespace :capsum do
  task "prepare_links" do
    on release_roles :all do
      [fetch(:linked_files), fetch(:linked_dirs)].compact.flatten.each do |path|
        target = release_path.join(path)
        execute :rm, target if test "[ -L #{target} ]"
      end
    end
  end
end

before "deploy:symlink:linked_files", "capsum:prepare_links"
