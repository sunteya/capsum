## TODO:

## v1.0:
- upgrade capistrano to v3.2, v2 is not compatible
- monkey patch for sshkit to support non-ascii in command
- upgrade capistrano-sidekiq to 0.2.5

## v0.9:
- use the official whenever recipe
- add sidekiq recipe support autostart

## v0.8:
- auto detect git setting by project git config
- always invoke deploy:cleanup after deploy:update
- support http_proxy variables

## v0.7:
- add daemons recipe

## v0.6:
- bundler only run on exist gemfile
- add rails cache clear recipe

## v0.5:
- add git recipe, support use current project's branch
- change typical recipe, now set :deploy_via, :copy
