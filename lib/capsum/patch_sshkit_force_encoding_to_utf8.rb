require "sshkit"

module SSHKit
  class Command
    alias_method :to_command_without_utf8, :to_command

    def to_command
      to_command_without_utf8.force_encoding('ASCII-8BIT')
    end
  end
end
