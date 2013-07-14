require File.expand_path("../../capsum.rb", __FILE__)

begin
  require "whenever/capistrano"
rescue LoadError => e
  # skip
end

Capistrano::Configuration.instance(true).load do
  set(:whenever_command) { fetch(:use_bundle, false) ? "#{fetch(:bundle_cmd, 'bundle')} exec whenever" : "whenever" }
  set(:whenever_options) { { roles: fetch(:whenever_roles), only: { whenever: true } } }
  set(:whenever_identifier) { deploy_to }
end
