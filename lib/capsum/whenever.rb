require "capsum"

begin
  require "whenever/capistrano"
rescue LoadError
  # skip
end

namespace :load do
  task :defaults do
    set(:whenever_identifier, -> { fetch :deploy_to })
    set(:whenever_roles, [ :db, filter: :whenever ])
  end
end

namespace :whenever do
  def setup_whenever_task(*args, &block)
    args = Array(fetch(:whenever_command)) + args
    on roles fetch(:whenever_roles) do |host|
      return if host.nil?
      args = args + Array(yield(host)) if block_given?
      within release_path do
        with fetch(:whenever_command_environment_variables) do
          execute *args
        end
      end
    end
  end
end