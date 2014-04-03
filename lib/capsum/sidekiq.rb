require "capsum"
require "capsum/daemons"

begin
  require 'capistrano/sidekiq'
rescue LoadError
  puts 'ERROR: If you want to use the "capsum/sidekiq". you must to add [ gem "capistrano-sidekiq", require: false ] to your Gemfile.'
  exit 1
end

namespace :sidekiq do
  task :update_daemon_list do
    scripts = []
    sidekiq_role = fetch(:sidekiq_role)
    on (roles sidekiq_role || []).first do |host|
      break if host.nil?
      for_each_process do |pid_file, idx|
        start_scripts = SimpleScriptRecord.new do
          start_sidekiq(pid_file)
        end

        stop_scripts = SimpleScriptRecord.new do
          stop_sidekiq(pid_file)
        end

        scripts << {
          start: start_scripts.to_bash,
          stop: stop_scripts.to_bash,
          pid_file: pid_file
        }
      end
    end

    scripts.each do |script|
      script[:role] = sidekiq_role
      script[:name] = File.basename(script[:pid_file], ".pid") if script[:pid_file]
    end

    fetch(:daemon_list).concat scripts
  end

  after 'daemons:prepare', :update_daemon_list
end

namespace :load do
  task :defaults do
    set :sidekiq_options, "--config config/sidekiq.yml"
    set :sidekiq_role, [ :db, filter: :sidekiq ]
  end
end

class SimpleScriptRecord < SSHKit::Backend::Printer
  attr_accessor :result

  def initialize(&block)
    @result = []
    @block = block
    self.run
  end

  def within(directory, &block)
    (@pwd ||= []).push directory.to_s
    yield
  ensure
    @pwd.pop
  end

  def to_bash
    result.map do |args|
      cmd = []
      options = args.extract_options!
      cmd << "cd #{options[:in]} && " if options[:in]
      cmd << args.join(" ")

      cmd.join
    end.join("\n")
  end

  def execute(*args)
    options = args.extract_options!
    options.merge!(in: @pwd.nil? ? nil : File.join(@pwd), env: @env, host: @host, user: @user, group: @group)
    @result << [ *args, options ]
  end

  def test(*args)
    raise SSHKit::Backend::MethodUnavailableError
  end

  def command(*args)
    raise SSHKit::Backend::MethodUnavailableError
  end
end