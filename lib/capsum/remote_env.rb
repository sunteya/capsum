module Capistrano
  module DSL
    def remote_env
      fetch(:remote_env)
    end
  end
end

module Capsum
  module RemoteEnv
    set_if_empty :remote_env, {}

    def on(hosts, options={}, &block)
      super(hosts, options) do
        with remote_env do
          instance_eval(&block)
        end
      end
    end
  end
end

extend Capsum::RemoteEnv
