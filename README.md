# Capsum

collect gems and recipes for capistrano.

## Installation

Add this line to your application's Gemfile:

    gem "capsum", require: false

## Usage

Add below files to your application.

### ./Capfile

~~~~ruby
require 'capistrano/setup'
require 'capistrano/deploy'

require "capsum/typical" # for rails project
# require "capsum/sidekiq"

require "capsum/rsync"
install_plugin Capsum::Rsync
~~~~

### ./config/deploy.rb

~~~~ruby
set :application, 'shipin8'

# fetch(:linked_files).concat %w{
#   config/database.yml
#   config/settings.local.rb
# }

# fetch(:linked_dirs).concat %w{
#   public/uploads
# }
~~~~

### ./config/deploy/uat.rb

~~~~ruby
set :deploy_to, -> { "/var/www/default/apps/#{fetch(:application)}" }
server 'host', user: 'www-data', roles: %w[web app db], primary: true # whenever: true, sidekiq: true

# bundle_env_variables[:http_proxy] = bundle_env_variables[:https_proxy] = "http://http_proxy_host:port"
~~~~

now, you can use below command to delpoy your application. for more information please see the source code.

	cap uat deploy

## Contributing

1. Fork it ( https://github.com/sunteya/capsum/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
