## config files

### `./Capfile`
	load 'deploy' if respond_to?(:namespace)
	Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
	load 'config/deploy'
	load 'deploy/assets'
	


### `./config/deploy.rb`

	require "capsum/typical"
	
	set :application, "portal"
	set :shared, %w{
	  config/application.local.rb
	}


### `./config/deploy/uat.rb`

	set :deploy_to, "/var/www/starcloud/apps/#{application}"
	
	set :user, "www-data"
	server "foo.bar.com", :app, :web, :db, :primary => true


## deploy command

	cap uat deploy
