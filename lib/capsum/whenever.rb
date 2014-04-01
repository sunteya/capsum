require File.expand_path("../../capsum.rb", __FILE__)

begin
  require "whenever/capistrano"
rescue LoadError => e
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
      host_args = Array(yield(host))
      within release_path do
        with fetch(:whenever_command_environment_variables) do
          execute *(args + host_args)
        end
      end
    end
  end
end